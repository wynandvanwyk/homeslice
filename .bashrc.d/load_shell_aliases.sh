if [ -d ~/.shell_aliases.d ]; then
  for file in ~/.shell_aliases.d/*.sh; do
    source "${file}"
  done
fi
