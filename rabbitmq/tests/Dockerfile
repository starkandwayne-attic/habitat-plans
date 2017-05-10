FROM starkandwayne/rabbitmq:edge

ENV PATH $PATH:/bin
ENV HOME /rabbitmq

COPY ./scripts/  /scripts
RUN mkdir -p /rabbitmq
RUN echo Gm0+QGpGcsEcxjJPEBY/Tg== > /rabbitmq/.erlang.cookie
RUN chmod 600 /rabbitmq/.erlang.cookie

ENTRYPOINT [""]

CMD ["echo"]
