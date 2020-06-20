# Kubernetes(K8s) Cluster On VirtualBox
This demo walks you through setting up Kubernetes cluster on a local machine using VirtualBox.

## Install VirtualBox
* wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
* wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
* echo "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" | sudo tee -a /etc/apt/sources.list.d/virtualbox.list
* sudo apt-get update
* sudo apt-get install -y virtualbox-6.1

## Minikube {Single Node K8s Cluster}
Minikube bundles all the these k8s components into a single image and providing us a pre-configured single node k8s cluster.

* Prerequisites - Hypervisor

> How to Run K8s Cluster using minikube:
* `cd minikube`
* `minikube start`

## Kubeadm {Multi Node K8s Cluster}
The kubeadm tool helps you bootstrap a minimum viable Kubernetes cluster that conforms to best practices

* Prerequisites - Hypervisor with 3 VMs setup

> How to Run K8s Cluster using kubeadm:
* `Follow all the 6 steps given in the kubeadm/kubeadm.sh`

## Vagrant {Multi Node K8s Cluster}
Vagrant is a tool for building and managing virtual machine environments in a single workflow. 
With an easy-to-use workflow and focus on automation, Vagrant lowers development environment setup time, increases production parity, and makes the "works on my machine" excuse a relic of the past.

* Prerequisites - Hypervisor

> Install Vagrant:
* curl -O https://releases.hashicorp.com/vagrant/2.2.9/vagrant_2.2.9_x86_64.deb
* sudo apt-get install ./vagrant_2.2.9_x86_64.deb
* vagrant --version

> How to Run K8s Cluster using vagrant:
* `cd vagrant`
* `vagrant up`

## Cluster Details

Kubernetes Cluster guides you through bootstrapping a highly available K8s cluster

* [Kubernetes](https://github.com/kubernetes/kubernetes) 1.13.0
* [Docker Container Runtime](https://github.com/containerd/containerd) 18.06
* [CNI Container Networking](https://github.com/containernetworking/cni) 0.7.5
* [Weave Networking](https://www.weave.works/docs/net/latest/kubernetes/kube-addon/)
* [etcd](https://github.com/coreos/etcd) v3.3.9


## Cluster Setup Labs Docs:

* [Prerequisites](docs/01-prerequisites.md)
* [Provisioning Compute Resources](docs/02-compute-resources.md)
* [Installing the Client Tools](docs/03-client-tools.md)
* [Provisioning the CA and Generating TLS Certificates](docs/04-certificate-authority.md)
* [Generating Kubernetes Configuration Files for Authentication](docs/05-kubernetes-configuration-files.md)
* [Generating the Data Encryption Config and Key](docs/06-data-encryption-keys.md)
* [Bootstrapping the etcd Cluster](docs/07-bootstrapping-etcd.md)
* [Bootstrapping the Kubernetes Control Plane](docs/08-bootstrapping-kubernetes-controllers.md)
* [Bootstrapping the Kubernetes Worker Nodes](docs/09-bootstrapping-kubernetes-workers.md)
* [TLS Bootstrapping the Kubernetes Worker Nodes](docs/10-tls-bootstrapping-kubernetes-workers.md)
* [Configuring kubectl for Remote Access](docs/11-configuring-kubectl.md)
* [Deploy Weave - Pod Networking Solution](docs/12-configure-pod-networking.md)
* [Kube API Server to Kubelet Configuration](docs/13-kube-apiserver-to-kubelet.md)
