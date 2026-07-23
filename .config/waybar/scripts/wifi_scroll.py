#!/usr/bin/env python3
import json
import subprocess
import time
import sys
import html

MAX_LEN = 10  # Visible length for Wi-Fi SSID

def get_wifi_info():
    try:
        res = subprocess.run(
            ["nmcli", "-t", "-f", "active,ssid,signal,device", "dev", "wifi"],
            capture_output=True,
            text=True,
            timeout=2
        )
        for line in res.stdout.splitlines():
            parts = line.split(":")
            if len(parts) >= 3 and parts[0] == "yes":
                ssid = parts[1]
                signal = parts[2] if len(parts) > 2 else "0"
                dev = parts[3] if len(parts) > 3 else "wlan0"
                return ssid, signal, dev
    except Exception:
        pass
    return None, None, None

def get_ip_address(dev):
    if not dev:
        return "Unknown"
    try:
        res = subprocess.run(
            ["ip", "-4", "addr", "show", dev],
            capture_output=True,
            text=True,
            timeout=2
        )
        for line in res.stdout.splitlines():
            line = line.strip()
            if line.startswith("inet "):
                return line.split()[1].split("/")[0]
    except Exception:
        pass
    return "Disconnected"

def get_scrolled_text(ssid, max_len, tick):
    if len(ssid) <= max_len:
        return ssid

    offset_max = len(ssid) - max_len
    pause_ticks = 6  # Pause at edges for readability
    total_ticks = pause_ticks + offset_max + pause_ticks + offset_max
    
    current_tick = tick % total_ticks
    
    if current_tick < pause_ticks:
        offset = 0
    elif current_tick < pause_ticks + offset_max:
        offset = current_tick - pause_ticks
    elif current_tick < pause_ticks + offset_max + pause_ticks:
        offset = offset_max
    else:
        offset = offset_max - (current_tick - (pause_ticks + offset_max + pause_ticks))
        
    return ssid[offset : offset + max_len]

def main():
    tick = 0
    last_net_check = 0
    ssid, signal, dev, ip_addr = None, None, None, None
    last_output = None
    
    while True:
        now = time.time()
        if now - last_net_check > 5 or ssid is None:
            ssid, signal, dev = get_wifi_info()
            ip_addr = get_ip_address(dev) if dev else "Disconnected"
            last_net_check = now

        if not ssid:
            output = json.dumps({"text": "󰖪 Disconnected", "tooltip": "No active Wi-Fi connection", "class": "disconnected"})
            if output != last_output:
                print(output)
                sys.stdout.flush()
                last_output = output
            time.sleep(1)
            continue

        try:
            sig_val = int(signal)
            if sig_val > 75:
                icon = "󰤨"
            elif sig_val > 50:
                icon = "󰤥"
            elif sig_val > 25:
                icon = "󰤢"
            else:
                icon = "󰤟"
        except ValueError:
            icon = "󰤨"

        display_ssid = get_scrolled_text(ssid, MAX_LEN, tick)
        display_text = f"{icon} {display_ssid}"
        
        safe_ssid = html.escape(ssid)
        safe_ip = html.escape(ip_addr)
        safe_dev = html.escape(dev or "")
        
        tooltip = f"<b>Wi-Fi Network</b>\nSSID: {safe_ssid}\nSignal: {signal}%\nIP Address: {safe_ip}\nDevice: {safe_dev}"

        output = json.dumps({
            "text": display_text,
            "tooltip": tooltip,
            "class": "connected"
        })

        if output != last_output:
            print(output)
            sys.stdout.flush()
            last_output = output
        
        tick += 1
        time.sleep(0.3)

if __name__ == "__main__":
    main()
