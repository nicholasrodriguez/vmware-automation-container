#!/bin/bash

yum -y install git
yum -y install vim
yum -y install python3
yum -y install python3-dns
yum -y install python3-netaddr
yum -y install epel-release
yum -y install python3-pyvmomi
yum -y install ansible

pip3 install --upgrade pyvmomi pyvim requests

# Install OVF Tool
cd /root/
curl -SLo ovftool.bundle ${OVF}
chmod u+x ovftool.bundle
./ovftool.bundle --eulas-agreed --required --console

# Fix Ovftool dependancy error
yum -y install libnsl

# Setup Modules for NSX-T due to VMware not setting up Ansible Galaxy properly :(
git clone https://github.com/vmware/ansible-for-nsxt.git /root/ansible-for-nsxt
cp -R /root/ansible-for-nsxt/plugins/modules/ /usr/share/ansible/plugins/
cp -R /root/ansible-for-nsxt/plugins/module_utils/ /usr/share/ansible/plugins/
cp -R /root/ansible-for-nsxt/plugins/doc_fragments/ /usr/share/ansible/plugins/

git clone https://github.com/vmware/ansible-module-vcloud-director.git /root/ansible-module-vcloud-director
cp -R /root/ansible-module-vcloud-director/modules/ /usr/share/ansible/plugins/
cp -R /root/ansible-module-vcloud-director/module_utils/ /usr/share/ansible/plugins/
cp -R /root/ansible-module-vcloud-director/roles/ /usr/share/ansible/

# Install Cloud Director Python Cli
pip3 install --no-cache-dir vcd-cli
vcd version

# Install Terraform
yum install -y yum-utils
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
yum -y install terraform
terraform -install-autocomplete

# Install Terraform VMware Providers
cd /root/terraform
terraform -chdir=/root/terraform init

# Clean up
rm -rf /root/ovftool.bundle
rm -rf /root/ansible-for-nsxt/
rm -rf /root/ansible-module-vcloud-director/
rm -rf /root/vcd*.log
