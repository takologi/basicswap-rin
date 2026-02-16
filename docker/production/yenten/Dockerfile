FROM i_swapclient as install_stage

RUN basicswap-prepare --preparebinonly --bindir=/coin_bin --withcoin=yenten --withoutcoin=particl && \
    find /coin_bin -name *.tar.gz -delete

FROM debian:bullseye-slim
COPY --from=install_stage /coin_bin .

ENV YENTEN_DATA /data

RUN groupadd -r yenten && useradd -r -m -g yenten yenten \
    && apt-get update \
    && apt-get install -qq --no-install-recommends gosu \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p "$YENTEN_DATA" \
    && chown -R yenten:yenten "$YENTEN_DATA" \
    && ln -sfn "$YENTEN_DATA" /home/yenten/.yenten \
    && chown -h yenten:yenten /home/yenten/.yenten
VOLUME /data

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 9253 9982
CMD ["/yenten/yentend", "--datadir=/data"]
