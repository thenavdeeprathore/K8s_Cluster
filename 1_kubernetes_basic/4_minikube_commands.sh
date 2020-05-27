# Minikube -> Single Node K8s Cluster
# -----------------------------------
# Minikube bundles all the these k8s components into a single image and providing us a pre-configured single node k8s cluster.
# Whole bundle is package into an iso image.

# Pre-requisites:
# ==============
# Hypervisor is required

# Actions:
# =======
# Minikube executable installed
# kubectl needs to be installed

# Go to C:\Kubernetes>


minikube start
		# Starting local Kubernetes cluster...
		# Running pre-create checks...
		# Creating machine...
		# Starting local Kubernetes cluster...


kubectl get nodes
		# NAME       STATUS   ROLES    AGE     VERSION
		# minikube   Ready    master   2m12s   v1.18.2

kubectl get pods
		# No resources found in default namespace.

kubectl create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.10
		# deployment.apps/hello-minikube created

kubectl get pods
		# NAME                              READY   STATUS    RESTARTS   AGE
		# hello-minikube-64b64df8c9-x9k9n   1/1     Running   0          18s

kubectl expose deployment hello-minikube --type=NodePort --port=8080
		# service/hello-minikube exposed

kubectl get pod
		# NAME                              READY   STATUS    RESTARTS   AGE
		# hello-minikube-64b64df8c9-x9k9n   1/1     Running   0          89s

minikube service hello-minikube --url
		# http://192.168.99.100:30776



		# Hostname: hello-minikube-64b64df8c9-x9k9n

		# Pod Information:
		# 	-no pod information available-

		# Server values:
		# 	server_version=nginx: 1.13.3 - lua: 10008

		# Request Information:
		# 	client_address=172.17.0.1
		# 	method=GET
		# 	real path=/
		# 	query=
		# 	request_version=1.1
		# 	request_scheme=http
		# 	request_uri=http://192.168.99.100:8080/

		# Request Headers:
		# 	accept=text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9
		# 	accept-encoding=gzip, deflate
		# 	accept-language=en-US,en;q=0.9
		# 	connection=keep-alive
		# 	host=192.168.99.100:30776
		# 	upgrade-insecure-requests=1
		# 	user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36

		# Request Body:
		# 	-no body in request-


kubectl delete services hello-minikube
		# service "hello-minikube" deleted

minikube dashboard
		# http://127.0.0.1:53837/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/#/overview?namespace=default

minikube stop
		# * Stopping "minikube" in virtualbox ...
		# * Node "minikube" stopped.

minikube delete
		# * Deleting "minikube" in virtualbox ...
		# * Removed all traces of the "minikube" cluster.




# minikube commands:

# Starts a local Kubernetes cluster
minikube start
# Retrieves the IP address of the running cluster
minikube ip
# Gets the status of a local Kubernetes cluster
minikube status
# Access the Kubernetes dashboard running within the minikube cluster
minikube dashboard
# pause K8s
minikube pause
# unpause K8s
minikube unpause
# Stops a running local Kubernetes cluster
minikube stop
# Deletes a local Kubernetes cluster
minikube delete
