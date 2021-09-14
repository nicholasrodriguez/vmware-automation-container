FROM centos:8

LABEL maintainer="nicholasrodriguez"

ARG OVF
ARG VERSION

ENV OVF_LOCATION=${OVF}

# Install Basic Requirements
RUN yum -y install git
RUN yum -y install vim
RUN yum -y install python3
RUN yum -y install python3-dns
RUN yum -y install python3-netaddr
RUN yum -y install epel-release
RUN yum -y install python3-pyvmomi
RUN yum -y install ansible
RUN yum -y install libnsl

# Install NSX-T Ansible Modules and Requirements
RUN curl -SLo ovftool.bundle ${OVF_LOCATION}
RUN chmod u+x ovftool.bundle
RUN ./ovftool.bundle --eulas-agreed --required --console

RUN git clone https://github.com/vmware/ansible-for-nsxt.git /root/ansible-for-nsxt
RUN cp -R /root/ansible-for-nsxt/plugins/modules/ /usr/share/ansible/plugins/
RUN cp -R /root/ansible-for-nsxt/plugins/module_utils/ /usr/share/ansible/plugins/
RUN cp -R /root/ansible-for-nsxt/plugins/doc_fragments/ /usr/share/ansible/plugins/

# Install Cloud Director Ansible Modules and Requirements
RUN git clone https://github.com/vmware/ansible-module-vcloud-director.git /root/ansible-module-vcloud-director
RUN cp -R /root/ansible-module-vcloud-director/modules/ /usr/share/ansible/plugins/
RUN cp -R /root/ansible-module-vcloud-director/module_utils/ /usr/share/ansible/plugins/
RUN cp -R /root/ansible-module-vcloud-director/roles/ /usr/share/ansible/

# Install Cloud Director Python Cli
RUN cd /root/
RUN pip3 install --no-cache-dir vcd-cli
RUN vcd version

# Install Terraform
RUN yum install -y yum-utils
RUN yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
RUN yum -y install terraform
RUN terraform -install-autocomplete

# Install Terraform VMware Providers
RUN mkdir /root/terraform
COPY main.tf /root/terraform/main.tf
RUN cd /root/terraform
RUN terraform -chdir=/root/terraform init

# Clean up
RUN rm -rf /ovftool.bundle
RUN rm -rf /root/ansible-for-nsxt/
RUN rm -rf /root/ansible-module-vcloud-director/
RUN rm -rf /vcd*.log

CMD ["/bin/bash"]
