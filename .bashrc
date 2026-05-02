alias nv=nvim

nvf() {
  local files
  files=$(fzf -m --preview 'bat --color=always --style=numbers --line-range=:500 {}')
  
  if [[ -n "$files" ]]; then
    echo "$files" | xargs -d '\n' nvim
  fi
}

nvr() {
    local file
    file="$(rg --column --line-number --no-heading --color=always --fixed-strings --ignore-case --glob '!.git/*' "$@" . | \
	fzf --ansi \
	--exact \
	--color "hl:-1:underline,hl+:-1:underline:bold" \
	--delimiter : \
	--preview 'bat --color=always --highlight-line {2} {1}' \
	--preview-window 'up,60%,border-bottom,+{2}+3/3' \
	--bind 'enter:become(nvim {1} +{2})')"
}

alias ff=fastfetch
alias zj="zellij a -c"
alias top=btop
alias ush="source ~/.bashrc"
alias bc="bc -ql"

alias l="ls -lh"
alias la="ls -lha"

alias ..="cd .."
alias ...="cd ../.."

alias ga="git add"
alias gcm="git commit -m"
alias gp="git push"
alias gpo="git push origin"

eval "$(zoxide init bash)"
eval "$(starship init bash)"

export BROWSER=firefox
export EDITOR="nvim"

alias blue=bluetuith
alias wifi=nmtui
