FROM alpine

ARG VERSION=2.6.1

RUN wget https://hfish.cn-bj.ufileos.com/hfish-${VERSION}-linux-amd64.tar.gz && \
    mkdir /hfish && tar xzvf hfish-${VERSION}-linux-amd64.tar.gz -C /hfish && \
    rm -rf hfish-${VERSION}-linux-amd64.tar.gz && \
    sed -i "s/sqlite3/mysql/g" /hfish/config_init.ini && \
    sed -i "s/^.*url.*$/url = root:HFish_123456@tcp(192.168.99.100:3306)\/hfish?charset=utf8\&parseTime=true\&loc=Local/" /hfish/config_init.ini

WORKDIR /hfish
EXPOSE 4433 4434
CMD [ "./server" ]
