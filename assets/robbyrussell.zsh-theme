# PROMPT="%(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} ) %{$fg[cyan]%}%c%{$reset_color%}"
# PROMPT+=' $(git_prompt_info)'

# ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
# ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
# ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}%1{✗%}"
# ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

function virtualenv_info {
    if [ $VIRTUAL_ENV ]; then
        python_path=$(which python)
        pip_path=$(which pip)
        # relative_python_path=${python_path#$PWD/}
        # relative_pip_path=${pip_path#$PWD/}

        test_result=""
        # If python is venv/bin//python, add ✓ python to the prompt else add ❌ python
        #if [[ $relative_python_path == *"venv/bin/python" ]]; then
        if [[ $python_path == $VIRTUAL_ENV"/bin/python" ]]; then
            test_result="✓ python "
        else
            test_result="❌ python "
        fi

        # If pip is venv/bin//pip, add ✓ pip to the prompt else add ❌ pip
        #if [[ $relative_pip_path == *"venv/bin/pip" ]]; then
        if [[ $pip_path == $VIRTUAL_ENV"/bin/pip" ]]; then
            test_result+="✓ pip"
        else
            test_result+="❌ pip"
        fi

        echo "(venv: $test_result) "
    fi
}

truncate_path() {
    local full_path="$PWD"
    local base_path="$HOME/www/projects"
    if [[ "$full_path" == "$base_path"* ]]; then
        echo "${full_path#$base_path/}"
    else
        echo "$full_path"
    fi
}

# PROMPT="[%*] %(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} ) %{$fg[cyan]%}%c%{$reset_color%}"
# PROMPT='[%*] %(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} ) %{$fg[cyan]%}$(truncate_path)%{$reset_color%}'
PROMPT='[%*] %{$fg[yellow]%}%m%{$reset_color%} %(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} ) %{$fg[cyan]%}$(truncate_path)%{$reset_color%}'
PROMPT+=' $(git_prompt_info)'

# Python venv
PROMPT+='%{$fg[green]%}$(virtualenv_info)%{$reset_color%}%'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}%1{✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
