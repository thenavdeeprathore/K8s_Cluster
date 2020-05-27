# Old way:
kubectl run nginx --image nginx
kubectl delete pod nginx

# New way -- deployment:
kubectl create deployment nginx --image=nginx
kubectl delete deployment nginx

# pod-definition
kubectl create -f pod-definition.yml
kubectl delete -f pod-definition.yml

# pods specific kubectl commands:
kubectl get pods
kubectl get pods -o wide
kubectl describe pod myapp-pod
kubectl describe pods
