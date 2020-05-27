# 1) Print the client and server versions for the current context
kubectl version --short
        # Client Version: v1.18.0
        # Server Version: v1.18.2

# 2) Display cluster info
kubectl cluster-info
        # Kubernetes master is running at https://192.168.99.101:8443
        # KubeDNS is running at https://192.168.99.101:8443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

# 3) nodes information
kubectl get node
kubectl get nodes
        # NAME       STATUS   ROLES    AGE   VERSION
        # minikube   Ready    master   38m   v1.18.2

# 4) pods information
kubectl get pods
        # No resources found in default namespace.

# 5) List all replication controllers and services together in ps output format.
kubectl get rc,services
        # NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
        # service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   51m

# 6) Describe all nodes
kubectl describe nodes

# 7) Describe all pods
kubectl describe pods

# Desribe all 
kubectl get all
        # NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
        # service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   7h52m
