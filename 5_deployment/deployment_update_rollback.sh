kubectl create -f deployment-definition.yml
    # deployment.apps/nginx-server-deployment created

kubectl rollout status deployment/nginx-server-deployment
    # Waiting for deployment "nginx-server-deployment" rollout to finish: 0 of 3 updated replicas are available...
    # Waiting for deployment "nginx-server-deployment" rollout to finish: 1 of 3 updated replicas are available...
    # Waiting for deployment "nginx-server-deployment" rollout to finish: 2 of 3 updated replicas are available...
    # deployment "nginx-server-deployment" successfully rolled out

kubectl rollout history deployment/nginx-server-deployment
    # deployment.apps/nginx-server-deployment
    # REVISION  CHANGE-CAUSE
    # 1         <none>

NOTE: CHANGE-CAUSE is none bcz I did not asked K8s to record the change that I made

kubectl delete deployment nginx-server-deployment
    # deployment.apps "nginx-server-deployment" deleted

kubectl create -f deployment-definition.yml --record
    # deployment.apps/nginx-server-deployment created

kubectl rollout history deployment/nginx-server-deployment
    # deployment.apps/nginx-server-deployment
    # REVISION  CHANGE-CAUSE
    # 1         kubectl create --filename=deployment-definition.yml --record=true

kubectl set image deployment/nginx-server-deployment nginx-container=nginx:1.9.1
    # deployment.apps/nginx-server-deployment image updated

kubectl rollout history deployment/nginx-server-deployment
    # deployment.apps/nginx-server-deployment
    # REVISION  CHANGE-CAUSE
    # 1         kubectl create --filename=deployment-definition.yml --record=true
    # 2         kubectl create --filename=deployment-definition.yml --record=true


# suppose there are issues with the last update
kubectl rollout undo deployment/nginx-server-deployment
    # deployment.apps/nginx-server-deployment rolled back

kubectl rollout history deployment/nginx-server-deployment
    # deployment.apps/nginx-server-deployment
    # REVISION  CHANGE-CAUSE
    # 2         kubectl create --filename=deployment-definition.yml --record=true
    # 3         kubectl create --filename=deployment-definition.yml --record=true
