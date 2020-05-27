# Replication Controller --> rc-definition.yml {Old Technology}
kubectl create -f rc-definition.yml
kubectl get replicationcontroller
kubectl describe replicationcontroller
kubectl delete replicationcontroller nginx-server-rc

# Replica Set --> replicaset-definition.yml
kubectl create -f replicaset-definition.yml
kubectl get replicaset
kubectl describe replicaset
# It will terminate and then create a new pod
kubectl delete pod nginx-server-replicaset
# It will not allow you to create new pods with the same label {in our case it's nginx-server}
kubectl create -f pod-definition.yml # It will termiante that pod

kubectl replace -f replicaset-definition.yml
kubectl scale --replicas=6 -f replicaset-definition.yml
kubectl scale --replicas=6 -f replicaset nginx-server-rs
kubectl delete replicaset nginx-server-rs

# common
kubectl get pods
kubectl get pods -o wide
