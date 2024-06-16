# 운영체제 ubuntu
FROM ubuntu:20.04

# 설치 시 사용자 입력을 요구하는 것을 방지하는 설정
ENV TZ Asia/Seoul
ENV DEBIAN_FRONTEND=noninteractive
ENV TOMCAT_VERSION=9.0.89
ENV CATALINA_HOME=/opt/tomcat

# 패키지 설치
RUN apt-get update && apt-get install -y openjdk-11-jdk

# Tomcat 다운로드 & 설치
RUN apt-get install -y wget && \
    wget https://downloads.apache.org/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    tar -xzf apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    mv apache-tomcat-${TOMCAT_VERSION} ${CATALINA_HOME} && \
    rm apache-tomcat-${TOMCAT_VERSION}.tar.gz

# JSP 파일을 Tomcat의 웹 애플리케이션 디렉토리에 복사 
COPY webapps/ROOT ${CATALINA_HOME}/webapps/ROOT

# Tomcat 포트 설정
EXPOSE 8080

# Tomcat 실행
CMD ["/opt/tomcat/bin/catalina.sh", "run"]