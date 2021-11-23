FROM ubuntu:focal

RUN \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install python3 python3-pip curl jq -y

RUN \
    pip3 install jupyterlab pymysql pandas matplotlib seaborn python-keycloak pyjwt

RUN mkdir /notebooks

COPY config.py /config.py

ENTRYPOINT /usr/local/bin/jupyter lab --ip 0.0.0.0 --allow-root --no-browser --config /config.py --notebook-dir=/notebooks

