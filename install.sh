#!/bin/bash

#First step
echo "Installing kubectl"

sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

#Second step install kvm driver

echo "Installing kvm driver"

sudo apt install qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils virt-manager

#This command permit you run commands for starting/stopping KVM virtual machines without sudo
sudo usermod -a -G libvirt $(whoami)
newgrp libvirt

#Third step install minikube binary

echo "Installing minikube"

curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
&& chmod +x minikube \
&& sudo mv minikube /usr/local/bin/

#Fourth step install kvm2 driver propietary from minikube

echo "Installing kvm2 driver"

curl -Lo docker-machine-driver-kvm2 https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-kvm2 \
&& chmod +x docker-machine-driver-kvm2 \
&& sudo cp docker-machine-driver-kvm2 /usr/local/bin/ \
&& rm docker-machine-driver-kvm2

#Final step
echo "Check your installation using this command"
echo "minikube start --vm-driver kvm2"
echo "Enjoy k8´s"
