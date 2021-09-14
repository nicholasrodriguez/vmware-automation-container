# vmware-automation-container
This repo builds an interactive container to run various VMware automation tooling for use in air-gapped environments for development work.

The container has the following installed:
* Python3
* Ansible
* Terraform
* VMware OVFTOOL

The container build hasn't been pushed to Docker Hub due to the inclusion of the Ovftool which may require licensing.

TODO - check licencing

# VMware components included
The following components are installed:
* NSX-T Ansible modules
* Cloud Director Ansible Modules and Roles
* Cloud Director Cli
* Terraform providers for
  * vcd
  * nsxt
  * avi

The Anisble modules and roles are all installed under /usr/share/ansible so should be accessible to Ansible
The Terraform providers have been installed under /root/terraform. Dev work can be performed in that directory.

# Container Build
Run ```./build.sh``` the BASH shell will ask for the location of the ovftool to download and the version number you want to tag the image with.

# Container Run
```
sudo docker run -i -t vmware-automation-container:1.0 bash
```
