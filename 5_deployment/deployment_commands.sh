# create deployment
kubectl create -f deployment-definition.yml

kubectl get all
        # NAME                                          READY   STATUS    RESTARTS   AGE
        # pod/nginx-server-deployment-b4f6d9f47-pzn9x   1/1     Running   0          23s
        # pod/nginx-server-deployment-b4f6d9f47-w5bbc   1/1     Running   0          23s
        # pod/nginx-server-deployment-b4f6d9f47-wtpw8   1/1     Running   0          23s

        # NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
        # service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   9h

        # NAME                                      READY   UP-TO-DATE   AVAILABLE   AGE
        # deployment.apps/nginx-server-deployment   3/3     3            3           23s

        # NAME                                                DESIRED   CURRENT   READY   AGE
        # replicaset.apps/nginx-server-deployment-b4f6d9f47   3         3         3       23s

kubectl describe deployment

kubectl get deployments
        # NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
        # nginx-server-deployment   3/3     3            3           2m30s

kubectl get replicaset
        # NAME                                DESIRED   CURRENT   READY   AGE
        # nginx-server-deployment-b4f6d9f47   3         3         3       11m

kubectl get pods
        # NAME                                      READY   STATUS    RESTARTS   AGE
        # nginx-server-deployment-b4f6d9f47-pzn9x   1/1     Running   0          3m14s
        # nginx-server-deployment-b4f6d9f47-w5bbc   1/1     Running   0          3m14s
        # nginx-server-deployment-b4f6d9f47-wtpw8   1/1     Running   0          3m14s

# delete deployment
kubectl delete -f deployment-definition.yml
kubectl delete deployment nginx-server-deployment


# summarize deployment, update, rollout commands:
# Create
kubectl create -f deployment-definition.yml
# Get
kubectl get deployments
# Update
kubectl apply -f deployment-definition.yml
kubectl set image deployment/nginx-server-deployment nginx-container=nginx:1.9.1
# Status
kubectl rollout status deployment/nginx-server-deployment
kubectl rollout history deployment/nginx-server-deployment
# Rollback
kubectl rollout undo deployment/nginx-server-deployment
