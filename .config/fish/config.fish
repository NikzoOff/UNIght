starship init fish | source

# ALIASES
alias i="yay -S"
alias iyu="yay -Syu"
alias iy="yay -Sy"
alias nv="nvim"
alias iss="yay -Ss"
alias ins="yay -Rns"
alias ls='eza --icons'
alias cat='bat --style=plain --paging=never'

fastfetch
if status is-interactive
    # Commands to run in interactive sessions can go here
end

