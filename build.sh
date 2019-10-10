$ docker build -t tomcat8:latest ./
$ docker container run -d --name tomcat_srv -p 89:8080 -v /usr/local/java/jdk8:/usr/local/jdk tomcat8:latest 
