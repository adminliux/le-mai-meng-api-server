FROM tomcat
ARG TOMCAT=/usr/local/tomcat
ARG TOMCAT_CONF=${TOMCAT}/conf
ARG WEBAPPS=${TOMCAT}/webapps
ARG ROOT=${WEBAPPS}/ROOT
ARG DEPENDENCY=
RUN mv ${ROOT} ${WEBAPPS}/main
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' >/etc/timezone
COPY ${DEPENDENCY}/meng-api-1.0 ${ROOT}
COPY ${DEPENDENCY}/context.xml ${TOMCAT_CONF}