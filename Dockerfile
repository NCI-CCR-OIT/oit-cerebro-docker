FROM amazoncorretto:11.0.25-al2023-headless AS builder

ARG CEREBRO_VERSION=0.9.4

RUN  yum -y install wget tar gzip \
 && yum clean all \
 && rm -rf /var/cache/yum \
 && mkdir -p /opt/cerebro/logs \
 && wget -qO- https://github.com/lmenezes/cerebro/releases/download/v${CEREBRO_VERSION}/cerebro-${CEREBRO_VERSION}.tgz \
  | tar xzv --strip-components 1 -C /opt/cerebro \
 && sed -i '/<appender-ref ref="FILE"\/>/d' /opt/cerebro/conf/logback.xml

FROM amazoncorretto:11.0.25-al2023-headless

COPY --from=builder /opt/cerebro /opt/cerebro

RUN  yum -y install shadow-utils \
 && yum clean all \
 && rm -rf /var/cache/yum
RUN /usr/sbin/groupadd --gid 1000 cerebro \
 && /usr/sbin/useradd --system --no-create-home --gid 1000 --uid 1000 cerebro \
 && chown -R root:root /opt/cerebro \
 && chown -R cerebro:cerebro /opt/cerebro/logs \
 && chown cerebro:cerebro /opt/cerebro

WORKDIR /opt/cerebro
USER cerebro

ENTRYPOINT [ "/opt/cerebro/bin/cerebro" ]
