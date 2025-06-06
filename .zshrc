# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

DISABLE_AUTO_UPDATE=true
DISABLE_MAGIC_FUNCTIONS=true
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
bindkey "^[[98;9u" backward-word
bindkey "^[[102;9u" forward-word
bindkey "^[[100;9u" kill-word
bindkey -r "^G"
bindkey "^D" delete-char
# TODO: Rebind some keys - forward/backward word, delete word, etc.

# -- Use catppuccin theme --
# Load catppuccin theme for bat
# export BAT_THEME="Catppuccin Mocha"
export BAT_THEME="rose-pine"
source ~/.config/zsh/rose-pine-man/rose-pine-man.zsh
export LOG_LEVEL="debug"

# Load catppuccin theme for zsh-syntax-highlighting
# source ~/.config/zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh

# -- Load plugins --
plugins=( fzf-tab fzf-zsh-completions fast-syntax-highlighting zsh-autosuggestions )
plugins+=(git) 
plugins+=(rust) # For cargo completions
plugins+=(zsh-vi-mode)
FPATH="/opt/homebrew/share/zsh/site-functions:${FPATH}"
FPATH="/opt/homebrew/share/zsh-completions:$FPATH"
# FPATH+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
# Do the initialization when the script is sourced (i.e. Initialize instantly)
ZVM_INIT_MODE=sourcing
source $ZSH/oh-my-zsh.sh

# ZSH Vim mode
export ZVM_CURSOR_STYLE_ENABLED=false
bindkey "^p" up-line-or-beginning-search
bindkey "^n" down-line-or-beginning-search
zvm_bindkey vicmd '^[' zvm_enter_insert_mode  # Enter insert mode when pressing escape in normal mode

# Pyenv initialization
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
pyenv() {
    eval "$(command pyenv init --path)"
    eval "$(command pyenv init - )"
    eval "$(command pyenv virtualenv-init -)"
    pyenv "$@"
}
# export DIRENV_LOG_FORMAT="[direnv: error] %s"
export DIRENV_LOG_FORMAT=
eval "$(direnv hook zsh)" 2> /dev/null

# pnpm
export PNPM_HOME="/Users/itamar/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Go configuration
export GOPATH="$HOME/go"
export PATH=$PATH:$HOME/go/bin
export EDITOR=nvim
export PATH="$HOME/.config/tmux/plugins/tmuxifier/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"
export LANG=en_US.UTF-8
export NODE_ENV=development
export ACCESS_SERVICES="{access-common,access-dispatcher,access-summarizer,az-access-evaluator,aws-access-evaluator,m365-identity-parser,snowflake-access-evaluator,google-identity-synchronizer,gcp-bigquery-access-evaluator}"

bindkey "^Gc" fzf-git-hashes-widget
alias dev="git checkout develop"
alias zconf="$EDITOR ~/.zshrc"
alias sz="source ~/.zshrc"
alias vim=nvim
alias cd=z
alias lg=lazygit
alias ta=tmux attach
alias l="eza --color=always --long --no-filesize --no-time --no-user --no-permissions --icons=auto"
alias opr="gh pr view --web"

eval "$(zoxide init zsh)"
eval "$(fnm env --use-on-cd --version-file-strategy=recursive)"
eval < "$HOME/.config/gh-copilot/copilot-alias.sh"
source "$HOME/.config/av/completions.sh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Accet suggestion
bindkey '^O' autosuggest-accept
bindkey '^Y' autosuggest-accept
bindkey '^[e' autosuggest-execute

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Dedicated completion key
export FZF_COMPLETION_TRIGGER=''
bindkey '^T' fzf-completion
bindkey '^I' $fzf_default_completion

# -- Use fd instead of fzf --
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}


# --- setup fzf theme ---
export FZF_THEME="
	--color=fg:#908caa,bg:#191724,hl:#ebbcba
	--color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
	--color=border:#403d52,header:#31748f,gutter:#191724
	--color=spinner:#f6c177,info:#9ccfd8
	--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"

export BASE_FZF_DEFAULT_OPTS=$FZF_THEME

export FZF_DEFAULT_OPTS="--tmux 80% $BASE_FZF_DEFAULT_OPTS"

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --icons=always --color=always {} | head -200; elif [ -f {} ]; then bat -n --color=always --line-range :500 {}; fi"

# export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --icons=always --color=always {} | head -200'"
#
# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --icons=always --color=always {} | head -200'   "$@" ;;
    export|unset) fzf --preview-window "wrap" --preview "eval 'echo \$'{}"                              "$@" ;;
    ssh)          fzf --preview 'dig {}'                                        "$@" ;;
    *)            
                  fzf --preview "$show_file_or_dir_preview"                     "$@" ;;
  esac
}

# fzf --bind 'enter:become(vim {})'

## Plugins configuration
### N_FZF_TAB fzf-tab
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:git-commit:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --tree --color=always $realpath' #$show_file_or_dir_preview # 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:*' popup-pad 0 0
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'
# tmux pop
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

# Set up fzf git completion
source ~/checkouts/fzf-git.sh/fzf-git.sh

# ----------------------------------------------------------------------------

# Workflows utils
CYERA_USERS="$HOME/.cyera-users"

export _fetch_cyera_users() {
  # Check if the file was modified in the last 3 days
  if [[ ! -e "$CYERA_USERS" || ! -n "$(find "$CYERA_USERS" -mtime -3 2>/dev/null)" ]]; then
    # File does not exist or was not modified in the last 3 days
    gh api /orgs/cyeragit/members -q '.[].login' --paginate > $CYERA_USERS
  fi
}

export _get_cyera_users() {
  gh api /orgs/cyeragit/members -q '.[].login' --paginate --cache "72h"
}

_complete_gh_send() { 
  COMPREPLY=($(compgen -W "$(_get_cyera_users | tr '\n' ' ')")) 
}

_fzf_complete_gh_send() {
  _fzf_complete --preview-window ",0" -- "$@" < <(
    _get_cyera_users
  )
}

_fzf_complete_send() {
  _fzf_complete --preview-window ",0" -- "$@" < <(
    _get_cyera_users
  )
}

_complete_lerna_packages() {
  COMPREPLY=$(compgen -W "$(lerna ls  -apl 2>/dev/null | cut -d : -f 2 | tr '\n' ' ')")
}

export get-base-ref() { GH_PAGER= gh pr view --json 'baseRefName' --jq '.baseRefName' 2> /dev/null|| echo "develop" }

export update-migrations() {
  BASE_BRANCH=$(get-base-ref) lerna run auto-increment-migration --scope data-collector-common
}

export send() {
  gh send "$@"
}

export assign() {
  gh assign "$@"
}

complete -F _complete_gh_send send
complete -F _complete_gh_send assign

export test-parallel() {
  parallel --jobs 10 "cd {} && npm run test > /dev/null 2>&1 && echo \"\033[38;5;2mPASS\033[38;5;255m - {}\" || echo \"\033[38;5;1mFAIL\033[38;5;255m - {}\"" ::: "$@"
}
complete -F _complete_lerna_packages test-parallel

export build-services() {
  packages_to_build=$(echo "$@" | tr ' ' ',')
  gh workflow run build-services.yml --ref $(git branch --show-current) -F packages_to_build=$packages_to_build
}
complete -F _complete_lerna_packages build-services

export e2e-cur() { gh workflow run testing-e2e.yml --ref $(git branch --show-current) }
export e2e-branch() { gh workflow run testing-e2e.yml --ref $1 }
complete -C "git branch" e2e-branch

export ltcheck() { lerna run type-check --stream --scope $1 }
complete -F _complete_lerna_packages ltcheck
export ltest() { lerna run test --stream --scope $1 }
complete -F _complete_lerna_packages ltest

alias gavyus="gh send barakg-cyera"
alias sharon="gh send sharona-cyera"

# Load Cyera shared rc file from our repository:
if [ -f /Users/itamar/checkouts/cyera/shared_rc/cyera_shared_rc.sh ]; then
    source /Users/itamar/checkouts/cyera/shared_rc/cyera_shared_rc.sh
else
    echo "Could not find Cyera shared rc file: /Users/itamar/checkouts/cyera/shared_rc/cyera_shared_rc.sh"
fi

if [ -f ~/cyera_run_autocomplete ]; then
    source ~/cyera_run_autocomplete
fi

alias lbs="lerna bootstrap -- --legacy-peer-deps"
alias leader-account="echo 745145878727 | pbcopy"
export SKIP_GET_SUDO=true
export AWS_PROFILE=default
