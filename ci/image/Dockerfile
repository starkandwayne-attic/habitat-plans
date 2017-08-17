FROM amidos/dcind

RUN apk --update add curl bash

RUN curl https://raw.githubusercontent.com/habitat-sh/habitat/master/components/hab/install.sh | bash
RUN hab -V

ENTRYPOINT []
