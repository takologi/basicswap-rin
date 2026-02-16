FROM i_swapclient as install_stage

RUN basicswap-prepare --preparebinonly --bindir=/coin_bin --withcoin=rincoin --withoutcoin=particl && \
    find /coin_bin -name *.tar.gz -delete

FROM debian:bullseye-slim
COPY --from=install_stage /coin_bin .

ENV RINCOIN_DATA /data

RUN groupadd -r rincoin && useradd -r -m -g rincoin rincoin \
    && apt-get update \
    && apt-get install -qq --no-install-recommends gosu \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p "$RINCOIN_DATA" \
    && chown -R rincoin:rincoin "$RINCOIN_DATA" \
    && ln -sfn "$RINCOIN_DATA" /home/rincoin/.rincoin \
    && chown -h rincoin:rincoin /home/rincoin/.rincoin
VOLUME /data

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 9555 9556
CMD ["/rincoin/rincoind", "--datadir=/data"]
