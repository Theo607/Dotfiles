#!/usr/bin/env python3
"""
Antigravity Token & Billing Usage Checker
Inspects local Antigravity CLI conversation databases and calculates token consumption
and estimated billing costs for the current project or all projects.
"""

import os
import sys
import glob
import sqlite3
import re
import argparse
import json
from pathlib import Path

APP_DATA_DIR = Path.home() / ".gemini" / "antigravity-cli"

# Pricing per 1,000,000 tokens (Gemini Flash standard rates)
PRICING = {
    "gemini-flash": {
        "input": 0.075 / 1_000_000,
        "output": 0.30 / 1_000_000,
        "cache": 0.01875 / 1_000_000,
    },
    "gemini-pro": {
        "input": 1.25 / 1_000_000,
        "output": 5.00 / 1_000_000,
        "cache": 0.3125 / 1_000_000,
    },
    "claude-sonnet": {
        "input": 3.00 / 1_000_000,
        "output": 15.00 / 1_000_000,
        "cache": 0.30 / 1_000_000,
    }
}

def decode_protobuf(data: bytes):
    """Simple protobuf varint and length-delimited wire decoder."""
    pos = 0
    length = len(data)
    fields = []
    while pos < length:
        key = 0
        shift = 0
        while True:
            if pos >= length: break
            b = data[pos]
            pos += 1
            key |= (b & 0x7f) << shift
            if not (b & 0x80): break
            shift += 7
        if pos > length or key == 0: break
        field_num = key >> 3
        wire_type = key & 7
        
        if wire_type == 0: # varint
            val = 0
            shift = 0
            while True:
                if pos >= length: break
                b = data[pos]
                pos += 1
                val |= (b & 0x7f) << shift
                if not (b & 0x80): break
                shift += 7
            fields.append((field_num, 'varint', val))
        elif wire_type == 2: # length delimited
            val_len = 0
            shift = 0
            while True:
                if pos >= length: break
                b = data[pos]
                pos += 1
                val_len |= (b & 0x7f) << shift
                if not (b & 0x80): break
                shift += 7
            val_bytes = data[pos:pos+val_len]
            pos += val_len
            fields.append((field_num, 'bytes', val_bytes))
        else:
            break
    return fields


def get_gcp_settings():
    settings_file = APP_DATA_DIR / "settings.json"
    if settings_file.exists():
        try:
            with open(settings_file, "r", encoding="utf-8") as f:
                data = json.load(f)
                return {
                    "project": data.get("gcp", {}).get("project", "N/A"),
                    "location": data.get("gcp", {}).get("location", "N/A"),
                    "model": data.get("model", "N/A")
                }
        except Exception:
            pass
    return {"project": "Unknown", "location": "Unknown", "model": "Unknown"}


def analyze_db(db_path: str):
    conn = sqlite3.connect(db_path)
    cur = conn.cursor()
    
    # Extract workspace path from metadata blob
    workspaces = set()
    try:
        cur.execute('SELECT data FROM trajectory_metadata_blob WHERE id="main";')
        row = cur.fetchone()
        if row and row[0]:
            matches = re.findall(rb'file://(/[^ \x00-\x1f\x7f-\xff]+)', row[0])
            for m in matches:
                path_str = m.decode(errors='ignore').rstrip('z')
                workspaces.add(path_str)
    except Exception:
        pass

    # Extract model name
    model_name = "Gemini 3.6 Flash"
    try:
        cur.execute('SELECT data FROM gen_metadata;')
        gen_rows = cur.fetchall()
        for g_row in gen_rows:
            if g_row and g_row[0]:
                m = re.search(rb'Gemini [^\x00-\x1f\x7f-\xff]+', g_row[0])
                if m:
                    model_name = m.group(0).decode(errors='ignore').split('.')[0] + " Flash"
                    break
    except Exception:
        pass

    # Extract steps & token usage
    cur.execute('SELECT idx, metadata FROM steps WHERE step_type=15;')
    steps = cur.fetchall()
    
    total_prompt = 0
    total_output = 0
    total_cache = 0
    total_thought = 0
    step_count = 0
    
    for idx, meta in steps:
        if not meta: continue
        fields = decode_protobuf(meta)
        for fnum, ftype, fval in fields:
            if fnum == 9 and ftype == 'bytes': # gen_metadata protobuf message inside step
                sub = decode_protobuf(fval)
                p_tok = 0
                o_tok = 0
                c_tok = 0
                th_tok = 0
                for sfnum, sftype, sfval in sub:
                    if sfnum == 2 and sftype == 'varint': p_tok = sfval
                    elif sfnum == 3 and sftype == 'varint': o_tok = sfval
                    elif sfnum == 5 and sftype == 'varint': c_tok = sfval
                    elif sfnum == 9 and sftype == 'varint': th_tok = sfval
                
                total_prompt += p_tok
                total_output += o_tok
                total_cache += c_tok
                total_thought += th_tok
                step_count += 1

    return {
        "conv_id": os.path.basename(db_path).replace(".db", ""),
        "workspaces": list(workspaces),
        "model": model_name,
        "steps": step_count,
        "prompt_tokens": total_prompt,
        "output_tokens": total_output,
        "cache_tokens": total_cache,
        "thought_tokens": total_thought,
    }


def format_number(val: int) -> str:
    return f"{val:,}"


def calculate_cost(prompt: int, output: int, cache: int, model_key="gemini-flash") -> float:
    rates = PRICING.get(model_key, PRICING["gemini-flash"])
    cost = (prompt * rates["input"]) + (output * rates["output"]) + (cache * rates["cache"])
    return cost


def main():
    parser = argparse.ArgumentParser(description="Antigravity Token & Billing Usage Checker")
    parser.add_argument("--workspace", "-w", type=str, default=os.getcwd(), help="Target workspace path (default: current directory)")
    parser.add_argument("--all", "-a", action="store_true", help="Show token usage across all projects")
    args = parser.parse_args()

    target_workspace = os.path.abspath(args.workspace)
    gcp_info = get_gcp_settings()

    db_files = glob.glob(str(APP_DATA_DIR / "conversations" / "*.db"))
    if not db_files:
        print("No Antigravity database files found.")
        sys.exit(1)

    all_stats = []
    for db_file in db_files:
        stats = analyze_db(db_file)
        all_stats.append(stats)

    # Filter for target project unless --all
    if not args.all:
        project_stats = [s for s in all_stats if any(target_workspace == w or target_workspace.startswith(w) or w.startswith(target_workspace) for w in s["workspaces"])]
    else:
        project_stats = all_stats

    # Cyan/Bold ANSI colors
    BOLD = "\033[1m"
    CYAN = "\033[36m"
    GREEN = "\033[32m"
    YELLOW = "\033[33m"
    RESET = "\033[0m"

    print(f"\n{BOLD}{CYAN}=========================================================={RESET}")
    print(f"{BOLD}{CYAN}      Antigravity CLI Token Usage & Billing Report       {RESET}")
    print(f"{BOLD}{CYAN}=========================================================={RESET}")
    print(f"{BOLD}Target Workspace:{RESET} {target_workspace if not args.all else 'ALL PROJECTS'}")
    print(f"{BOLD}GCP Project:{RESET}      {gcp_info['project']}")
    print(f"{BOLD}Location:{RESET}         {gcp_info['location']}")
    print(f"{BOLD}Configured Model:{RESET} {gcp_info['model']}")
    print(f"{CYAN}----------------------------------------------------------{RESET}\n")

    if not project_stats or sum(s["steps"] for s in project_stats) == 0:
        print(f"{YELLOW}No usage recorded yet for this project.{RESET}\n")
        return

    total_prompt = 0
    total_output = 0
    total_cache = 0
    total_thought = 0
    total_steps = 0

    print(f"{BOLD}{'Session ID':<38} | {'Steps':<6} | {'Prompt Tok':<11} | {'Output Tok':<10} | {'Cache Tok':<11}{RESET}")
    print("-" * 86)

    for s in project_stats:
        if s["steps"] == 0:
            continue
        total_prompt += s["prompt_tokens"]
        total_output += s["output_tokens"]
        total_cache += s["cache_tokens"]
        total_thought += s["thought_tokens"]
        total_steps += s["steps"]

        conv_short = s["conv_id"][:36]
        print(f"{conv_short:<38} | {s['steps']:<6} | {format_number(s['prompt_tokens']):<11} | {format_number(s['output_tokens']):<10} | {format_number(s['cache_tokens']):<11}")

    print("-" * 86)
    print(f"{BOLD}{'TOTAL':<38} | {total_steps:<6} | {format_number(total_prompt):<11} | {format_number(total_output):<10} | {format_number(total_cache):<11}{RESET}")
    print()

    # Cost calculation
    est_cost_flash = calculate_cost(total_prompt, total_output, total_cache, "gemini-flash")
    est_cost_pro = calculate_cost(total_prompt, total_output, total_cache, "gemini-pro")

    print(f"{BOLD}{GREEN}--- Consumption Summary ---{RESET}")
    print(f" • Total Input Tokens:      {format_number(total_prompt)}")
    print(f" • Total Output Tokens:     {format_number(total_output)} (including {format_number(total_thought)} thinking tokens)")
    print(f" • Total Cached Context:    {format_number(total_cache)}")
    print(f" • Total LLM Steps / Calls: {total_steps}")
    print()
    print(f"{BOLD}{GREEN}--- Estimated Billing / Cost ---{RESET}")
    print(f" • Account / Billing Tier:  {BOLD}{gcp_info['project']}{RESET} (Google Cloud / Vertex AI)")
    print(f" • Est. Cost (Gemini Flash): {GREEN}${est_cost_flash:.4f} USD{RESET}")
    print(f" • Est. Cost (if Gemini Pro): {YELLOW}${est_cost_pro:.4f} USD{RESET}")
    print(f"\n{CYAN}Note: Actual billing depends on your GCP project quota, subscription tier, or enterprise credits.{RESET}\n")

if __name__ == "__main__":
    main()
