for file in ~/.bashrc.d/*; do
  if [ $file == "/home/${USER}/.bashrc.d/init.sh" ]; then
    continue
  fi
  source $file
done
