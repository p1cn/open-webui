# source version
ARG version
# env, dev, test, prod
ARG env
# harbor host
ARG harbor
ARG service

FROM hub.p1.cn/cicd/lingualink_base:v1

COPY backend/requirements.txt /
RUN python3 -m pip install -i https://pypi.tuna.tsinghua.edu.cn/simple -U pip
RUN python3 -m pip install -i https://pypi.tuna.tsinghua.edu.cn/simple -r requirements.txt

ENV http_proxy="http://10.10.1.81:2345" \
    https_proxy="http://10.10.1.81:2345" \
    DATABASE_URL="pending" \
    VECTOR_DB="pgvector" \
    PGVECTOR_DB_URL="pending"

RUN apt-get update && \
    apt-get install -y \
    sqlite3

COPY . /
COPY deploy/backend/prod/entrypoint.sh /
RUN chmod +x /entrypoint.sh

WORKDIR /
ENTRYPOINT /bin/sh -c /entrypoint.sh