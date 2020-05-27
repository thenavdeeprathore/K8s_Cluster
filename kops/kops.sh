********************************************************************************
# Prerequisites:
- Ubuntu instance
- AWS-cli setup
- S3 bucket
********************************************************************************


********************************************************************************
# STEP 1: launch one ubuntu instance and execute below steps to install kops::
- ssh to ec2 instance
********************************************************************************
ssh -i ~/.ssh/yourprivatekey.pem ec2-user@yourpublickey
cat /etc/os-release


********************************************************************************
# STEP 2: setup aws-cli on ubuntu to interact with aws::
********************************************************************************
apt-get update
apt-get install -y python-pip
pip install awscli
aws --version


********************************************************************************
# STEP 3: aws configure::
********************************************************************************
## aws configure
aws configure
    AWS Access Key ID: USER_ACCESS_KEY_HERE
    AWS Secret Access Key: USER_SECRET_KEY_HERE
    Default region name: us-east-1
    Default output format: Click enter for None


********************************************************************************
# STEP 3.1: create IAM user & make a note of Access key ID & Secruity access key::
- Add new user with Access Type: Programmatic access
- Attach existing policies
# STEP 3.2: create S3 bucket and enable versioning::
- Create bucket: navdeep-k8s-kops-state-bucket
- Enable versioning {storing the state of your cluster}
- Check properties tab that versioning is enabled
********************************************************************************
## check bucket in aws
aws s3 ls
## check ec2 instances types
aws ec2 describe-instances

## create bucket
aws s3api create-bucket --bucket navdeep-k8s-kops-state-bucket
## check newly created bucket
aws s3 ls navdeep-k8s-kops-state-bucket
## enable bucket versioning
aws s3api put-bucket-versioning --bucket navdeep-k8s-kops-state-bucket --region us-east-1 --versioning-configuration Status=Enabled

## export kops state variable for the bucket
export KOPS_STATE_STORE=s3://navdeep-k8s-kops-state-bucket


********************************************************************************
# STEP 4: kubectl - installation in AWS::
- Client-side tool to interact with Kubernetes Cluster
- Create Pod
- Create Service
- Deployment
********************************************************************************
## Download kubectl binary
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
## Give execute permission to this binary
chmod +x ./kubectl
## Move this binary to /usr/local/bin/ such that this command will be in the path
sudo mv ./kubectl /usr/local/bin/kubectl
## check kubectl client and server version
kubectl version --short


********************************************************************************
# STEP 5: KOPS - (Kubernetes Operations) installation in AWS::
- automation tool by aws to create, destroy and upgrade Kubernetes clusters
- “the easiest way to get a production-grade Kubernetes cluster up and running”
- describe itself as ‘kubectl’ for spinning up clusters
********************************************************************************
## Download kops binary
wget https://github.com/kubernetes/kops/releases/download/v1.16.2/kops-linux-amd64
## Give execute permission to this binary
chmod +x kops-linux-amd64
## Move this binary to /usr/local/bin/ so that we don't have to type this kops-linux-amd64
sudo mv kops-linux-amd64 /usr/local/bin/kops
## check kops path
which kops
## check kops version
kops version


********************************************************************************
# STEP 6: Environment variables setup:: (Optional)
- Update these two variables in .bashrc & .profile in ~ dir for future sessions, otherwise they are only available for this session
- Remember cluster name should ends with k8s.local
********************************************************************************
vi ~/.bashrc
export KOPS_CLUSTER_NAME=navdeep.k8s.local
export KOPS_STATE_STORE=s3://navdeep-k8s-kops-state-bucket

vi ~/.profile
export KOPS_CLUSTER_NAME=navdeep.k8s.local
export KOPS_STATE_STORE=s3://navdeep-k8s-kops-state-bucket


********************************************************************************
# STEP 7: Create cluster:: This will actually prepare the configuration files
- Master node per zone {us-east-1a}
- Currently there is no high-availibility since only one zone is configured

kops create cluster will configure:
- vpc
- subnet
- security groups
- route table
- load balancer
- instance profiles
- ssh access
etc

- We already have a load balancer with our current master node, in future we can just add another master node
********************************************************************************
## CONFIG CLUSTER
kops create cluster \
--cloud=aws \
--zones=us-east-1a \
--image=ami-03c652d3a09856345 \
--master-count=1 \
--node-count=3 \
--master-size=t2.large \
--node-size=t2.micro \
--kubernetes-version 1.16.0 \
--topology private \
--networking calico \
--name=${KOPS_CLUSTER_NAME}


## get cluster information
kops get cluster

## (optional) if you want to review & edit the cluster configuration:
kops edit cluster --name ${KOPS_CLUSTER_NAME}

## CREATE CLUSTER: if you're okay withe the configuration run the command with --yes as like below:
kops update cluster --name ${KOPS_CLUSTER_NAME} --yes

    Output shows like below..::
    Cluster is starting.  It should be ready in a few minutes.

    Suggestions:
    * validate cluster: kops validate cluster
    * list nodes: kubectl get nodes --show-labels
    * ssh to the master: ssh -i ~/.ssh/id_rsa admin@api.navdeep.k8s.local
    * the admin user is specific to Debian. If not using Debian please use the appropriate user based on your OS.
    * read about installing addons at: https://github.com/kubernetes/kops/blob/master/docs/addons.md.

## VALIDATE CLUSTER
kops validate cluster

    Validating cluster navdeep.k8s.local

    INSTANCE GROUPS
    NAME                    ROLE    MACHINETYPE     MIN     MAX     SUBNETS
    master-us-east-1a       Master  t2.large         1       1       us-east-1a
    nodes                   Node    t2.micro         3       3       us-east-1a

    NODE STATUS
    NAME                            ROLE    READY
    ip-172-20-39-123.ec2.internal   node    True
    ip-172-20-46-91.ec2.internal    node    True
    ip-172-20-52-88.ec2.internal    node    True
    ip-172-20-54-252.ec2.internal   master  True

    Your cluster navdeep.k8s.local is ready

## get cluster information
kops get cluster

## config file path
ls .kube

## check kubectl client and server version
kubectl version --short

## get nodes
kubectl get nodes

## get namespaces
kubectl get ns

    default
    kube-node-lease
    kube-public
    kube-system

## get storage class
kubectl get sc

    default
    gp2 (default)

## kubesystem get all
kubectl -n kube-system get all


********************************************************************************
# STEP 8: Deploy nginx server
********************************************************************************
kubectl run nginx --image nginx

kubectl get all

## port forwarding
kubectl port-forward nginx-56af45gh67-5gh78 8080:80

## check on browser
localhost:8080

## delete nginx
kubectl delete deploy nginx


********************************************************************************
# STEP 9: ssh to Master Node
********************************************************************************
# Create Private and Public key
ssh-keygen -t rsa -b 2048 -c "My AWS Key Pair"
ls .ssh/id_rsa

# ssh to Master Node
# ssh -i .ssh/yourprivatekey admin@publicIPAddress
ssh admin@publicIPAddress
cat /etc/os-release
logout


********************************************************************************
# STEP 10: upgrade kubernetes cluster
- edit/upgrade
- update
- rolling-update
********************************************************************************
kops get cluster

# WAY 1: {specific version}
## upgrade kubernetes server version to 1.16.3
kops edit cluster --name ${KOPS_CLUSTER_NAME}
## update cluster
kops update cluster --name ${KOPS_CLUSTER_NAME} --yes
## update one node at a time starting from master node
## since there is only one master node, there will be downtime
kops rolling-update cluster --name ${KOPS_CLUSTER_NAME} --yes

# WAY 2: {latest}
## upgrade kubernetes server version to latest
kops upgrade cluster --name ${KOPS_CLUSTER_NAME} --yes
## update cluster
kops update cluster --name ${KOPS_CLUSTER_NAME} --yes
## update one node at a time starting from master node
## since there is only one master node, there will be downtime
kops rolling-update cluster --name ${KOPS_CLUSTER_NAME} --yes

kops validate cluster --name ${KOPS_CLUSTER_NAME}
kubectl get nodes
kubectl version --short


********************************************************************************
# STEP 11: scaling kubernetes cluster
- add node {master/worker}
- remove node {master/worker}
- update node {master/worker}
********************************************************************************
kops validate cluster --name ${KOPS_CLUSTER_NAME}
kubectl get nodes

## get instance group for auto scaling
kops get instancegroups --name ${KOPS_CLUSTER_NAME}
kops get ig --name ${KOPS_CLUSTER_NAME}

## add / remove worker nodes {maxSize: 5}
kops edit ig nodes --name ${KOPS_CLUSTER_NAME}
## add / remove master nodes {maxSize: 3}
kops edit ig master-us-east-1a --name ${KOPS_CLUSTER_NAME}

## update cluster
kops update cluster --name ${KOPS_CLUSTER_NAME} --yes
## not required but no harm in running this command
kops rolling-update cluster --name ${KOPS_CLUSTER_NAME} --yes

kops validate cluster --name ${KOPS_CLUSTER_NAME}
kubectl get nodes

## NOTE: if cpu utilization goes above 70% in any nodes, add manually
- go to aws to auto scaling groups
- there will be 2 auto scaling groups one for master one for worker nodes
- select any one of them and go to scaling policies tab
- add policy manually


********************************************************************************
# STEP 12: delete kubernetes cluster
- delete cluster {this will also delete the cluster state store files inside s3 bucket}
- empty s3 bucket {this will remove all the versioning objects}
- delete s3 bucket
********************************************************************************
kops get cluster
kops validate cluster --name ${KOPS_CLUSTER_NAME}
kubectl get nodes

## delete cluster
kops delete cluster --name ${KOPS_CLUSTER_NAME} --yes

## empty s3 bucket
aws s3 rm s3://navdeep-k8s-kops-state-bucket --recursive

## delete s3 bucket
aws s3 rb s3://navdeep-k8s-kops-state-bucket --force  



********************************************************************************
# STEP 13: Kubernetes Networking Options
The networking options determines how the pod and service networking is implemented and managed.

Kubernetes Operations (kops) currently supports 3 networking modes:
- kubenet(default): Kubernetes native networking via a CNI plugin. This is the default.
- cni: Container Network Interface(CNI) style networking, often installed via a Daemonset.
- external: networking is done via a Daemonset. This is used in some custom implementations.

Kubernetes Operations (kops) uses kubenet networking by default
One important limitation when using kubenet networking is that an AWS routing table cannot have more than 50 entries, which sets a limit of 50 nodes per cluster

CNI
===
Container Network Interface provides a specification and libraries for writing plugins to configure network interfaces in Linux containers.
Kubernetes has built in support for CNI networking components.

Several CNI providers are currently built into kops:
- AWS VPC
- Calico
- Canal (Flannel + Calico)
- Cilium
- Flannel
- Kube-router
- Lyft VPC
- Romana
- Weave

networking calcio {different overlay network}
- pod security policies
- secure the connection and traffic flows between the pods
- like a firewall
- my pod on this namespace can talk to other pod on another namespace
- like creating inbound/outbound ingress outgress security groups
********************************************************************************


********************************************************************************
# STEP 14: helm charts
- Use Helm to deploy the Nginx web server docker containers on Kubernetes cluster
********************************************************************************
## Install Helm -- Download your desired version

## Unpack helm binary
tar -zxvf helm-v3.0.0-linux-amd64.tar.gz

## Find the helm binary in the unpacked directory, and move it to its desired destination
mv linux-amd64/helm /usr/local/bin/helm

## check helm version
helm version --short --client
