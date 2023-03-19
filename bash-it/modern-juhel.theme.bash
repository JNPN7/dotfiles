# shellcheck shell=bash
# shellcheck disable=SC2034 # Expected behavior for themes.
# shellcheck disable=SC2154 #TODO: fix these all.

SCM_THEME_PROMPT_PREFIX=""
SCM_THEME_PROMPT_SUFFIX=""

SCM_THEME_PROMPT_DIRTY=" ${bold_red}✗${normal}"
SCM_THEME_PROMPT_CLEAN=" ${bold_green}✓${normal}"
SCM_GIT_CHAR="${bold_green}±${normal}"
SCM_SVN_CHAR="${bold_cyan}⑆${normal}"
SCM_HG_CHAR="${bold_red}☿${normal}"

THEME_CHECK_SUDO=true

prompt_color=${cyan}

name="\u ⚓ \h ✨ \t 🥁 "
# python="${green}$(python_version_prompt)${normal}"
# node="$(node_version_prompt)"

case $TERM in
	xterm*)
		TITLEBAR="\[\033]0;\w\007\]"
		;;
	*)
		TITLEBAR=""
		;;
esac

PS3=">> "

is_vim_shell() {
	if [ -n "$VIMRUNTIME" ]; then
		echo "[${cyan}vim shell${normal}]"
	fi
}

detect_venv() {
	python_venv=""
	# Detect python venv
	if [[ -n "${CONDA_DEFAULT_ENV}" ]]; then
		python_venv="($PYTHON_VENV_CHAR${CONDA_DEFAULT_ENV}) "
	elif [[ -n "${VIRTUAL_ENV}" ]]; then
		python_venv="($PYTHON_VENV_CHAR$(basename "${VIRTUAL_ENV}")) "
	fi
}

# check if running with sudo privilages to change color
check_sudo() {
	if [[ "${THEME_CHECK_SUDO}" = true ]]; then
        prompt_color=${cyan}
		sudo -vn 1> /dev/null 2>&1 && prompt_color=${yellow}
	fi
}

prompt() {
    check_sudo
    SCM_PROMPT_FORMAT='[%s][%s]'
	retval=$?
	if [[ retval -ne 0 ]]; then
		PS1="\n${TITLEBAR}${bold_red}┌─${reset_color}[${prompt_color}${name}${normal}][${green}$(python_version_prompt)${normal}][${purple}node$(node_version_prompt)${normal}][${cyan}\w${normal}]$(is_vim_shell)\n${bold_red}└─🦉→ ${normal} "
	else
		PS1="\n${TITLEBAR}┌─[${prompt_color}${name}${normal}][${green}$(python_version_prompt)${normal}][${purple}node$(node_version_prompt)${normal}][${cyan}\w${normal}]$(is_vim_shell)"
	fi
	# detect_venv
	PS1+="\n└─$(scm_prompt)🦉→ ${python_venv}${dir_color}"
}

PS2="└-▪ "

safe_append_prompt_command prompt
