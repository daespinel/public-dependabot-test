FROM python:3.9-slim-buster
#REPOSITORY=test
# TAGS=latest

COPY docker-entrypoint.sh /

RUN groupadd -g 1000 -r python \
 && useradd --no-log-init -u 1000 -r -g python python \
 && apt-get -y -q update --no-install-recommends \
 && apt-get -y -q install --no-install-recommends curl gosu net-tools procps \
 && TINI_VERSION="v0.19.0" \
 && curl -L https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini -o /tini \
 && chmod +x /tini \
 && apt-get -y update && pip install --upgrade pip \
 && apt-get -y -q install --no-install-recommends g++ libcairo2 gir1.2-gtk-3.0 

ENTRYPOINT ["tini","--","/docker-entrypoint.sh"]

WORKDIR /home/python/app

COPY --chown=root:root --chmod=755 requirements.txt .

RUN pip install -r requirements.txt \
 && apt-get -y -q purge gcc  \
 && apt-get clean autoclean \
 && apt-get autoremove --yes \
 && rm -rf /var/lib/{apt,dpkg,cache,log}/

COPY --chown=root:root --chmod=755 . . 

EXPOSE 80

USER python

CMD ["python","main.py"]
