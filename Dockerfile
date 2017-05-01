# build is-tcserver:latest
# docker build tcserver -t is-tcserver:latest
FROM centos:7
EXPOSE 6969 8080 8443

RUN yum install -y vim wget java git

# install yum repo
#RUN rpm --import http://packages.gopivotal.com/pub/rpm/rhel6/app-suite/RPM-GPG-KEY-PIVOTAL-APP-SUITE-EL6
RUN rpm --import http://packages.gopivotal.com/pub/rpm/rhel7/app-suite/RPM-GPG-KEY-PIVOTAL-APP-SUITE-EL7
RUN yum-config-manager --add-repo http://packages.pivotal.io/pub/rpm/rhel7/app-suite/x86_64

# install tcserver
RUN yum install -y pivotal-tc-server-standard

# set JAVA_HOME to the java version installed by yum
RUN cd ~
ENV JAVA_HOME /usr

# install tcserver instance (01)
RUN mkdir -p /web/tcserver
RUN /opt/pivotal/pivotal-tc-server-standard/tcruntime-instance.sh create -i /web/tcserver 01

# add default manager.war and a test admin user to login to manager.war with.
ADD webapps/manager.war /web/tcserver/01/webapps
ADD conf/tomcat-users.xml /web/tcserver/01/conf

ADD target/hello-world.war /web/tcserver/01/webapps

# start the tcserver instance which will be PID 1
ENTRYPOINT ["/web/tcserver/01/bin/tcruntime-ctl.sh", "run"]
