FROM ubuntu:12.04
MAINTAINER ricardoamaro <ricardo.amaro@acquia.com>

ENV HOME /root
#ADD . /build
ENV DEBIAN_FRONTEND noninteractive
# Keep upstart from complaining
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

# Scripts
ADD ./scripts/start.sh /sbin/start.sh


RUN apt-get update
RUN apt-get install -y --force-yes openssh-server cron

RUN mkdir /var/run/sshd
RUN echo 'root:somepassword' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH fix for permanent login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Make start.sh executable
RUN chmod 755 /sbin/start.sh

EXPOSE 22
CMD ["/bin/bash", "/sbin/start.sh"]