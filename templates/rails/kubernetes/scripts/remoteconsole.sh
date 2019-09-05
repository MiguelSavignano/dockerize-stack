POD_NAME="$(kubectl get pod | awk '{print $1;}' | grep rails-nginx | head -n 1)"
kubectl exec ${POD_NAME} -c rails -it -- bash
