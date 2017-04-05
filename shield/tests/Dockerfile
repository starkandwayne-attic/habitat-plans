FROM starkandwayne/shield:edge

RUN hab pkg install core/jq-static && hab pkg binlink core/jq-static jq
ENV PATH $PATH:/bin

COPY ./scripts/ /scripts

ENTRYPOINT []
CMD [echo]
