if [ -d ~/.shell_functions.d ]; then
  for file in ~/.shell_functions.d/*.sh; do
    source "${file}"
  done
fi
