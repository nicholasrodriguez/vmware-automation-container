FROM centos:8

LABEL maintainer="nicholasrodriguez"

ARG OVF

ENV OVF_LOCATION=${OVF}

# Prepare the Image
RUN mkdir /root/terraform
COPY main.tf /root/terraform/main.tf
COPY install_tools.sh /root/install_tools.sh

# Install the tools
RUN /root/install_tools.sh

CMD ["/bin/bash"]
