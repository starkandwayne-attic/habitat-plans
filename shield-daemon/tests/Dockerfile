FROM starkandwayne/shield:edge

RUN hab pkg install core/jq-static && hab pkg binlink core/jq-static jq
RUN hab pkg install core/aws-cli/1.10.43/20161214024307 && hab pkg binlink core/aws-cli aws
RUN hab pkg install core/curl && hab pkg binlink core/curl curl
ENV PATH $PATH:/bin

COPY ./scripts/ /scripts

ENTRYPOINT []
CMD [echo]
