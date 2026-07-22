alias nv=nvim
alias hx=helix

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

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export GOPATH="$HOME/.local/share/go"
export PATH="$GOPATH/bin:$PATH"
export GOBIN="$HOME/.local/bin"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}



[ -f "/home/theo/.ghcup/env" ] && . "/home/theo/.ghcup/env" # ghcup-env
export PATH="/home/theo/.cargo/bin:$PATH"
export PATH="$PATH:/home/theo/.local/bin"
