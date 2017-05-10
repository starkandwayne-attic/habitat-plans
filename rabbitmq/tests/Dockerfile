FROM starkandwayne/rabbitmq:edge

# psql
RUN set -x \
      && apk add --update bash jq curl rabbitmq alpine-sdk linux-headers \
      && rm -rf /var/cache/apk/*

COPY ./scripts/  /scripts

CMD ["/bin/true"]
