access_key=YOUR_AWS_ACCESS_KEY_ID
SECRET=YOUR_AWS_SECRET_ACCESS_KEY


IdentityFile /Users/amitkumar/Documents/terraform_aws/akumar.pem
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 172.31.27.42:6443 --token 5oc76h.wrim73vwz9qt8evj \
        --discovery-token-ca-cert-hash sha256:59b42438c6f5a7daa4110d9d8fbe14ba44a8e472a2bf39d3a5857b8226ce43b2 


kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/tigera-operator.yaml

wget https://raw.githubusercontent.com/projectcalico/calico/v3.26.4/manifests/custom-resources.yaml

kubectl get pod tigera-operator-778d567d8b-kr8f8 -n tigera-operator -o jsonpath='{.status.reason}{"\n"}{.status.message}{"\n"}'


sudo swapoff -a 
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstabsudo swapoff -a sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# Load required modules
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

# Configure sysctl parameters
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# Apply sysctl parameters immediately
sudo sysctl --system

sudo apt-get update
sudo apt-get install -y containerd

# Generate default configuration and enforce systemd cgroup driver
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml >/dev/null
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/g' /etc/containerd/config.toml

# Restart containerd to apply changes
sudo systemctl restart containerd
sudo systemctl enable containerd

sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gpg

# Download the public signing key
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://packages.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# Add the repository to your system sources
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list


sudo apt-get update
version=1.29.11-1.1
sudo apt-get install -y kubelet=$version kubeadm=$version kubectl=$version
sudo apt-mark hold kubelet kubeadm kubectl

sudo kubeadm init --pod-network-cidr=192.168.0.0/16


mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config


Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/


kubeadm join 172.31.22.151:6443 --token fnpqos.lvxag6pst6bx7otz \
        --discovery-token-ca-cert-hash sha256:a9c822048e50201ba878ad2714a406d423b4b0343f55dd30825f3451ba74cdb7 