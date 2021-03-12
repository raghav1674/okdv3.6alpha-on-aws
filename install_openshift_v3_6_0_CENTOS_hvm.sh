#!/bin/bash
echo "Enter the public ec2 hostname: "
read hostname
echo "Enter the public ip of ec2 or the eip attached to the instance: "
read ip
yum install docker vim  wget -y 
echo "********************************************DISABLING SELINUX**********************************************"
setenforce 0
systemctl start docker
echo "***********************************DOWNLOADING OPENSHIFT v3.6.0 ALPHA VERSION******************************************************"
wget https://github.com/openshift/origin/releases/download/v3.6.0-alpha.0/openshift-origin-client-tools-v3.6.0-alpha.0-0343989-linux-64bit.tar.gz
tar -xzf openshift-origin-client-tools-v3.6.0-alpha.0-0343989-linux-64bit.tar.gz
cp openshift-origin-client-tools-v3.6.0-alpha.0-0343989-linux-64bit/oc /usr/local/bin/
echo OPTIONS="--default-ulimit nofile=1024:4096 --insecure-registry 172.30.0.0/16" >>  /etc/sysconfig/docker
systemctl restart docker
echo "****************************************STARTING OKDv3.6.0  CLUSTER*****************************************"
oc cluster up --routing-suffix=$ip.nip.io --public-hostname=$hostname



