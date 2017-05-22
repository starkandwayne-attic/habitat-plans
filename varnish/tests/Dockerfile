FROM starkandwayne/varnish:edge

RUN set -x && hab pkg install core/bash && hab pkg binlink core/bash bash && \
  hab pkg install core/jq-static && hab pkg binlink core/jq-static jq && \
  hab pkg install core/curl && hab pkg binlink core/curl curl

ENV PATH $PATH:/bin

COPY ./scripts/ /scripts

ENTRYPOINT []

CMD ["echo"]
