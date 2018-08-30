FROM tomcat:8.5

ENV GEOSERVER_DATA_DIR /data/geoserver
ENV GEOSERVER_DOWNLOAD_URL https://sourceforge.net/projects/geoserver/files/GeoServer/2.11.2/geoserver-2.11.2-war.zip

RUN apt-get update && apt-get -y install unzip
RUN wget -q $GEOSERVER_DOWNLOAD_URL -O /tmp/geoserver-war.zip
RUN unzip -q /tmp/geoserver-war.zip -d /tmp
RUN mv /tmp/geoserver.war $CATALINA_HOME/webapps/geoserver.war
RUN mkdir /data && mkdir $GEOSERVER_DATA_DIR
RUN echo JAVA_OPTS="$JAVA_OPTS -Djava.security.egd=file:/dev/./urandom" >> $CATALINA_HOME/bin/setenv.sh

EXPOSE 8080
VOLUME ["/data/geoserver"]
CMD ["catalina.sh", "run"]
