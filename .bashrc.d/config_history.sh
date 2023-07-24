# Ensure bash history is not lost when terminal crashes
HISTSIZE=100000
HISTFILESIZE=200000
PROMPT_COMMAND='history -a;history -n'
