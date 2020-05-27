# Dynamic IP
kubectl get pods -o wide
    # NAME                                      READY   STATUS    RESTARTS   AGE   IP           NODE       NOMINATED NODE   READINESS GATES
    # nginx-server-deployment-b4f6d9f47-g5p6j   1/1     Running   0          24m   172.17.0.8   minikube   <none>           <none>
    # nginx-server-deployment-b4f6d9f47-nf4n6   1/1     Running   0          24m   172.17.0.6   minikube   <none>           <none>
    # nginx-server-deployment-b4f6d9f47-r5m79   1/1     Running   0          24m   172.17.0.7   minikube   <none>           <none>


# Each node has internal private network
# And PODs get IP address within that private network range
