FROM centos:latest
LABEL maintainer="IAC"
 
ENV VERSION=8.5.46
ENV JAVA_HOME=/usr/local/jdk
 
RUN yum install wget curl unzip iproute net-tools -y && \
    yum clean all && \
    rm -rf /var/cache/yum/*
 
COPY . /
 
RUN tar zxf apache-tomcat-${VERSION}.tar.gz && \
    mv apache-tomcat-${VERSION} /usr/local/tomcat && \
    rm -rf apache-tomcat-${VERSION}.tar.gz /usr/local/tomcat/webapps/* && \
    mkdir /usr/local/tomcat/webapps/ROOT && \
    echo '<h1>Hello,Tomcat!</h1>' > /usr/local/tomcat/webapps/ROOT/status.html && \
    sed -i '1a JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom"' /usr/local/tomcat/bin/catalina.sh && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
 
ENV PATH $PATH:/usr/local/tomcat/bin
WORKDIR /usr/local/tomcat
EXPOSE 8080
CMD ["catalina.sh", "run"]
