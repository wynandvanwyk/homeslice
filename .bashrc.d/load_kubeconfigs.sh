KUBECONFIG=~/.kube/config
for kubefile in ~/.kube/*.yaml; do
  export KUBECONFIG=$KUBECONFIG:$kubefile
done
