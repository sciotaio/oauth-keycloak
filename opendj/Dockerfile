FROM openjdk:11-slim-buster

RUN apt-get update && apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install unzip wget -y
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG ADD_BASE_ENTRY="--addBaseEntry"

ARG PORT=1389

ARG BASE_DN="dc=sciota,dc=io"

ARG ROOT_USER_DN="cn=Directory Manager"
ENV ROOT_USER_DN=${ROOT_USER_DN}

ARG ROOT_PASSWORD=blafasel
ENV ROOT_PASSWORD=${ROOT_PASSWORD}

ARG VERSION=4.4.14

WORKDIR /opt

RUN wget https://github.com/OpenIdentityPlatform/OpenDJ/releases/download/$VERSION/opendj-$VERSION.zip && \
  unzip opendj-$VERSION.zip && \
  rm -r opendj-$VERSION.zip

RUN /opt/opendj/setup --cli -p $PORT \
  --baseDN $BASE_DN -h localhost --rootUserDN "$ROOT_USER_DN" --rootUserPassword "$ROOT_PASSWORD" \
  --acceptLicense --no-prompt $ADD_BASE_ENTRY --doNotStart -v
#
# add postfix schema to directory
#COPY 99-postfix-schema.ldif /opt/opendj/config/schema/99-postfix-schema.ldif

# add openssh schema to directory
#COPY 99-openssh-lpk-schema.ldif /opt/opendj/config/schema/99-openssh-lpk-schema.ldif

RUN cat /opt/opendj/config/config.ldif|sed "s/ds-cfg-backend-id: userRoot/ds-cfg-backend-id: userRoot\nds-cfg-je-property: je.freeDisk=104857600/g" > /opt/opendj/config/config2.ldif
RUN mv /opt/opendj/config/config2.ldif /opt/opendj/config/config.ldif

# init directory with sciota nodes
COPY init.ldif /var/tmp/init.ldif
RUN \
  /opt/opendj/bin/start-ds && \
  /opt/opendj/bin/ldapmodify -D "$ROOT_USER_DN" -w "$ROOT_PASSWORD" -f /var/tmp/init.ldif -p $PORT -c && \
  /opt/opendj/bin/stop-ds

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE $PORT 4444

# start ds (detached) and schedule daily backup task at 2am (dn and pass are env variables visible with docker inspect)
# other backup methods involve either installing opendj in the backup container or accessing opendj container from backup container, because export-ldif or backup command is needed.
# accessing opendj container from backup container involves mounting the docker socket from the docker host (suboptimal because of security implications)
ENTRYPOINT ["/entrypoint.sh"]
