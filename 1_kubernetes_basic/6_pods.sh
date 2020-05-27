# POD
# ---
# Containers are not deployed directly on the nodes, instead they are encapsulated into a k8s object known as a POD
# Pod is a single instance of an application
# Smallest unit you can create in Kubernetes object model is POD
# A Pod can only have one container in it: FALSE
# Right approach to scale an application: Deploy additional PODS


# Create a POD:
# NOTE: we can't access the nginx server directly by our host, only accessible by the node currently
kubectl run nginx --image nginx
    # pod/nginx created


# List all pods in ps output format.
kubectl get pods
    # NAME    READY   STATUS    RESTARTS   AGE
    # nginx   1/1     Running   0          45s


# List all pods in ps output format with more information (such as ip, node name).
kubectl get pods -o wide
    # NAME    READY   STATUS    RESTARTS   AGE   IP           NODE       NOMINATED NODE   READINESS GATES
    # nginx   1/1     Running   0          69s   172.17.0.4   minikube   <none>           <none>

# Describe a pod
kubectl describe pods/nginx


# Describe all pods
kubectl describe pods


# Create an NGINX Pod (using --restart=Never)
# If you run the kubectl run command without the --restart=Never OR the --generator=run-pod/v1, the command will create a deployment instead (as of version 1.16).
# Note that this way of creating a deployment is deprecated and should not be used.
kubectl run nginx --image=nginx --restart=Never


# Instead, use kubectl create command to create a deployment
kubectl create deployment nginx --image=nginx

# Delete pods
# kubectl run nginx --image nginx
kubectl delete pod nginx
# kubectl create deployment nginx --image=nginx
kubectl delete deployment nginx
