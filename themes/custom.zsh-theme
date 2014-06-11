

# ---------- helper_space() ---------------------------------------------------
helper_space() {
    echo -n ' '
}


# ---------- helper_git() -----------------------------------------------------
helper_git() {
  local ref dirty mode repo_path
  repo_path=$(git rev-parse --git-dir 2>/dev/null)

  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    dirty=$(parse_git_dirty)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git show-ref --head -s --abbrev |head -n1 2> /dev/null)"
    if [[ -n $dirty ]]; then
      echo -n '%{%F{yellow}%}'
    else
      echo -n '%{%F{green}%}'
    fi

    if [[ -e "${repo_path}/BISECT_LOG" ]]; then
      mode=" <B>"
    elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
      mode=" >M<"
    elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
      mode=" >R>"
    fi

    setopt promptsubst
    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' get-revision true
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr 'staged'
    zstyle ':vcs_info:git:*' unstagedstr 'unstaged'
    zstyle ':vcs_info:*' formats ' %u%c'
    zstyle ':vcs_info:*' actionformats ' %u%c'
    vcs_info

    echo -n "< ${ref/refs\/heads\//@}${vcs_info_msg_0_%% } ${mode}>"
  fi
}


# ---------- prompt_status() --------------------------------------------------
prompt_status() {
    [[ $RETVAL -ne 0 ]] && echo -n '%{%F{red}%}✘ (%?)'
    [[ $RETVAL -eq 0 ]] && echo -n '%{%F{green}%}✓'
    [[ $UID -eq 0 ]] && echo -n ' %{%F{yellow}%}⚡'
    [[ $(jobs -l | wc -l) -gt 0 ]] && echo -n ' %{%F{cyan}%}⚙'
}


# ---------- prompt_dir() -----------------------------------------------------
prompt_dir() {
    echo -n '%{%F{blue}%}%~'
}

# ---------- prompt_host() ----------------------------------------------------
prompt_host() {
    [[ -z $ZSH_HIDEUSER ]] && echo -n '%{%F{yellow}%}%n'
    [[ -z $ZSH_HIDEHOST ]] && echo -n '%{%F{yellow}%}@%m'
}

# ---------- prompt_prompt() --------------------------------------------------
prompt_prompt() {
    echo -n '$'
}

# ---------- build_prompt() ---------------------------------------------------
build_prompt() {
    RETVAL=$?
    echo
    helper_space
    prompt_status
    helper_space
    prompt_host
    helper_space
    prompt_dir
    echo
    helper_space
    prompt_prompt
    helper_space
}

PROMPT='%{%f%b%k%}$(build_prompt)%{%f%b%k%}'


# ---------- rps1_time() ------------------------------------------------------
rps1_time() {
    [[ -z $ZSH_HIDETIME ]] && echo -n "%{%F{cyan}%}[$(echo $(date) | cut -d' ' -f4)]"
}

# ---------- rps1_faces() -----------------------------------------------------
rps1_faces() {
    [[ -z $ZSH_HIDEFACE ]] || return
    [[ $RETVAL -ne 0 ]] && echo -n '%{%F{red}%}:('
    [[ $RETVAL -eq 0 ]] && echo -n '%{%F{green}%}:)'
}

# ---------- build_rps1() -----------------------------------------------------
build_rps1() {
    RETVAL=$?
    helper_git
    helper_space
    rps1_time
    helper_space
    rps1_faces
}

RPS1='%{%f%b%k%}$(build_rps1)%{%f%b%k%}'



