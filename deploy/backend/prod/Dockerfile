# source version
ARG version
# env, dev, test, prod
ARG env
# harbor host
ARG harbor
ARG service

FROM hub.p1.cn/cicd/gpt-oi-rest-base:v1

COPY backend/requirements.txt /

RUN python3 -m pip install -i https://pypi.tuna.tsinghua.edu.cn/simple -U pip
RUN python3 -m pip install -i https://pypi.tuna.tsinghua.edu.cn/simple -r requirements.txt

ENV ENV="prod" \
    http_proxy="http://10.10.1.81:2345" \
    https_proxy="http://10.10.1.81:2345" \
    DATABASE_URL="postgresql://dbuser_oi:lksdu7832JD%23jkYE78jd@qianshou-oidb-master.p1.cn:6432/ttx-oi" \
    VECTOR_DB="pgvector" \
    PGVECTOR_DB_URL="postgresql://dbuser_oi:lksdu7832JD%23jkYE78jd@qianshou-oidb-master.p1.cn:6432/ttx-oi" \
    RAG_EMBEDDING_ENGINE="openai" \
    RAG_EMBEDDING_MODEL="text-embedding-3-small" \
    WEBUI_AUTH_TRUSTED_NAME_HEADER="webauth-username" \
    WEBUI_AUTH_TRUSTED_EMAIL_HEADER="webauth-email" \
    RAG_WEB_SEARCH_TRUST_ENV="true" \
    BYPASS_WEB_SEARCH_EMBEDDING_AND_RETRIEVAL="true" \
    BYPASS_EMBEDDING_AND_RETRIEVAL="true"


RUN apt-get update && \
    # Install pandoc and netcat
    apt-get install -y --no-install-recommends git build-essential pandoc netcat-openbsd curl && \
    # for RAG OCR
    apt-get install -y --no-install-recommends ffmpeg libsm6 libxext6 && \
    # install helper tools
    apt-get install -y --no-install-recommends curl jq && \
    # Install pandoc, netcat and gcc
    apt-get install -y --no-install-recommends gcc python3-dev && \
    # cleanup
    rm -rf /var/lib/apt/lists/*;

COPY . /
COPY deploy/backend/prod/entrypoint.sh /
RUN chmod +x /entrypoint.sh

WORKDIR /
ENTRYPOINT /bin/sh -c /entrypoint.sh