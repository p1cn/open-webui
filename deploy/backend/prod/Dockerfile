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

RUN curl -O https://sqlite.org/2021/sqlite-autoconf-3350000.tar.gz && \
    tar -xvzf sqlite-autoconf-3350000.tar.gz && \
    cd sqlite-autoconf-3350000 && \
    ./configure && \
    make && \
    sudo make install


COPY . /
COPY deploy/backend/prod/entrypoint.sh /
RUN chmod +x /entrypoint.sh

WORKDIR /
ENTRYPOINT /bin/sh -c /entrypoint.sh