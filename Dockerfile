FROM centos:7

RUN yum update -y
RUN yum install -y openssh-server openssh-clients sudo

RUN adduser gustavo 
RUN echo "gustavo  ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN mkdir -p /home/gustavo/.ssh
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -q -N "" -t rsa -f /home/gustavo/.ssh/id_rsa
# RUN cp /home/gustavo/.ssh/id_rsa.pub /home/gustavo/.ssh/authorized_keys
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
ADD id_rsa.pub /home/gustavo/.ssh/authorized_keys
RUN chown -R gustavo /home/gustavo/.ssh; chmod 700 /home/gustavo/.ssh

RUN chmod 600 /home/gustavo/.ssh/authorized_keys

EXPOSE 22
CMD    ["/usr/sbin/sshd", "-D"]
