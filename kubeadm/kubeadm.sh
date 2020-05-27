# STEP 1:
# Install 3 VMs and install the openssh-server
apt-get update
apt-get install openssh-server
service ssh status

# ssh to all 3 VMs using their unique IP

# updat ethe hostname on all 3 VMs
# VM 1
vi /etc/hostname
vi /etc/hosts
kube-master
# VM 2
vi /etc/hostname
vi /etc/hosts
kube-node1
# VM 3
vi /etc/hostname
vi /etc/hosts
kube-node2
# shutdown all VMs after updating unique hostnames

# VM settings --> Network --> Adapter 1 --> Enable Network Adapter --> Attach To: Bridged Adapter
# VM settings --> Network --> Adapter 2 --> Enable Network Adapter --> Attach To: Host-only Adapter


# Making IP address static for all VMs
# kube-master
vi /etc/network/interfaces
auto enp0s8
iface enp0s8 inet static
        address 192.168.56.2
        netmask 255.255.255.0
# kube-node1
address 192.168.56.3
# kube-node2
address 192.168.56.4


# disable swap in all 3 VMs
swapoff -a
vi /etc/fstab
# comment the bottom line which is swap


# STEP 2:
sudo apt-get update
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
# To use Docker as a non-root user, you should now consider adding your user to the “docker” group
sudo usermod -aG docker navdeep


# STEP 3:
sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl


# STEP 4:
# kube-master
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=192.168.56.2


# STEP 5:
# To start using your cluster, you need to run the following as a regular user:
mkdir -p $HOME/.kube
sudo cp -i /ect/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
# You should now deploy a Pod network to the cluster.
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/v0.10.0/Documentation/kube-flannel.yml
kubectl get pods --all --namespaces


# STEP 6:
# kube-node1
# kube-node2
kubeadm join <control-plane-host>:<control-plane-port> --token <token> --discovery-token-ca-cert-hash sha256:<hash>


# kube-master
kubectl get nodes

kubectl run nginx --image=nginx
kubectl get pods
