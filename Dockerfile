FROM eclipse-temurin:25-jre-alpine

ARG _WORKDIR=/app

ENV _WORKDIR=${_WORKDIR}

WORKDIR ${_WORKDIR}

# Download-Tool installieren
RUN apk add --no-cache wget

# Minecraft Server JAR herunterladen
RUN wget -O ${_WORKDIR}/server.jar https://piston-data.mojang.com/v1/objects/823e2250d24b3ddac457a60c92a6a941943fcd6a/server.jar

RUN echo "eula=true" > ${_WORKDIR}/eula.txt

COPY . ${_WORKDIR}

ENV APPLICATION_PORT=25565
ENV JVM_XMX=2G
ENV JVM_XMS=1G

EXPOSE ${APPLICATION_PORT}

RUN chmod +x ${_WORKDIR}/entrypoint.sh

ENTRYPOINT ${_WORKDIR}/entrypoint.sh
