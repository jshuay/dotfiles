machine="windows"

# Colors
# run `spectrum_ls` to see colors
primary_color=%{$FG[015]%} # gruvbox white
# secondary_color=%{$FG[102]%}
name_color=%{$FG[015]%} # gruxbox white
# name_color=%{$FG[037]%} # cloudbox
date_color=%{$FG[012]%} # gruvbox red
ok_status_color=%{$FG[010]%} # gruvbox green
error_status_color=%{$FG[009]%} # gruvbox red
directory_color=%{$FG[011]%} # gruvbox yellow
git_color=%{$FG[014]%} # gruvbox red
git_dirty_color=%{$FG[013]%} # gruvbox red
reset_color=%{$reset_color%}

# Components
bold_start=%B
bold_end=%b

year=%D{%Y}
month=%D{%m}
day=%D{%d}
hour=%D{%H}
minute=%D{%M}
second=%D{%S}
date="${year}.${month}.${day} ${hour}:${minute}:${second}"

name=%n

new_line=$'\n'

exit_status=%(?.0.!)

full_directory=%~
short_directory=%1~

# Git
ZSH_THEME_GIT_PROMPT_PREFIX=" ‹${git_color}"
ZSH_THEME_GIT_PROMPT_SUFFIX="${primary_color}›"
ZSH_THEME_GIT_PROMPT_DIRTY="${git_dirty_color}*${primary_color}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
# Load version control information
#autoload -Uz vcs_info
#precmd() { vcs_info }
#zstyle ':vcs_info:git:*' formats '(%b)'
#setopt PROMPT_SUBST

# Prompt
main_prompt='${name_color}${name}@${machine} ${date_color}${date} ${primary_color}‹%(?.${ok_status_color}.${error_status_color})${exit_status}${primary_color}› ${directory_color}${full_directory}${primary_color}$(git_prompt_info) »${reset_color} '

secondary_prompt="${secondary_color}${date} <%(?.${ok_status_color}.${error_status_color})${exit_status}${secondary_color}> ${full_directory}${reset_color}"

PROMPT=${main_prompt}
#RPROMPT=\$vcs_info_msg_0_
# RPROMPT='$(git_prompt_info)'
