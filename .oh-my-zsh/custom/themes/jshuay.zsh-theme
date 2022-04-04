machine="windows"

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
ZSH_THEME_GIT_PROMPT_PREFIX=" "
ZSH_THEME_GIT_PROMPT_SUFFIX=" "
ZSH_THEME_GIT_PROMPT_DIRTY=" *"
ZSH_THEME_GIT_PROMPT_CLEAN=""
# Load version control information
#autoload -Uz vcs_info
#precmd() { vcs_info }
#zstyle ':vcs_info:git:*' formats '(%b)'
#setopt PROMPT_SUBST

# Colors
primary_color=%{$FG[124]%}
secondary_color=%{$FG[102]%}
ok_status_color=%{$FG[034]%}
error_status_color=%{$FG[009]%}
reset_color=%{$reset_color%}

# Prompt
main_prompt="${primary_color}${bold_start}${name}@${machine} [${short_directory}] @>${bold_end}${reset_color} "

secondary_prompt="${secondary_color}${date} <%(?.${ok_status_color}.${error_status_color})${exit_status}${secondary_color}> ${full_directory}${reset_color}"

PROMPT=${secondary_prompt}${new_line}${main_prompt}
#RPROMPT=\$vcs_info_msg_0_
RPROMPT='$(git_prompt_info)'
