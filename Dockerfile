FROM centos
MAINTAINER Robert Greathouse <robert.i.greathouse@gmail.com>

#Set HTTP(S)_PROXY for update from behind Ferguson proxy
ENV http_proxy http://$PROXY_LOGIN:$PROXY_PASSWORD@$PROXY_IP:$PROXY_PORT
ENV https_proxy http://$PROXY_LOGIN:$PROXY_PASSWORD@$PROXY_IP:$PROXY_PORT

#Update OS
RUN yum -y update

#Install Apache Web Server
RUN yum -y install httpd

#Set httpd to run on startup
#RUN systemctl enable httpd

#Start httpd service
#RUN systemctl start httpd

#Cleanup after install
RUN yum -y clean all

#Configure Apache Web Server
ENV APACHE_RUN_USER apache
ENV APACHE_RUN_GROUP apache
ENV APACHE_LOG_DIR /etc/httpd/logs

EXPOSE 80
EXPOSE 443

#Remove HTTP(S) Proxy settings
ENV http_proxy ""
ENV https_proxy ""

CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
