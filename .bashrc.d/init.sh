for file in ~/.bashrc.d/*.sh; do
  if [ $file == "/home/${USER}/.bashrc.d/init.sh" ]; then
    continue
  fi
  source $file
done

# Load kubeconfig files
KUBECONFIG=~/.kube/config
for kubefile in ~/.kube/*.yaml; do
  export KUBECONFIG=$KUBECONFIG:$kubefile
done

# Load functions
if [ -d ~/.bashrc.d/functions ]; then
  for file in ~/.bashrc.d/functions/*.sh; do
    source "${file}"
  done
fi

# Load installers
if [ -d ~/.bashrc.d/installers ]; then
  for file in ~/.bashrc.d/installers/*.sh; do
    source "${file}"
  done
fi
