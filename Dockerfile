FROM       ubuntu:16.04
MAINTAINER "https://github.com/jrajaniemi/ubuntu-openconnect"

RUN apt-get update

RUN apt-get install -y openssh-server joe wget openconnect dnsutils docker.io curl ca-certificates x509-util
RUN wget https://github.com/openshift/origin/releases/download/v3.7.0/openshift-origin-client-tools-v3.7.0-7ed6862-linux-64bit.tar.gz
RUN tar zxvf openshift-origin-client-tools-v3.7.0-7ed6862-linux-64bit.tar.gz
RUN mv openshift-origin-client-tools-v3.7.0-7ed6862-linux-64bit/oc /usr/local/bin

RUN mkdir /var/run/sshd

RUN echo 'root:tuut' |chpasswd

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

EXPOSE 22

CMD    ["/usr/sbin/sshd", "-D"]
