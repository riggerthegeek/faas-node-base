FROM node:8-alpine

ARG FWATCHDOG_VERSION

ENV cgi_headers="true"
ENV fprocess="node index.js"

# Add the fwatchdog - this is cached
RUN apk --no-cache add curl \
    && echo "Pulling watchdog binary from Github." \
    && curl -sSL https://github.com/openfaas/faas/releases/download/${FWATCHDOG_VERSION}/fwatchdog > /usr/bin/fwatchdog-v${FWATCHDOG_VERSION} \
    && ln -s /usr/bin/fwatchdog-v${FWATCHDOG_VERSION} /usr/bin/fwatchdog \
    && chmod +x /usr/bin/fwatchdog \
    && apk del curl --no-cache

# chmod for tmp is for a buildkit issue (@alexellis)
RUN chmod 777 /tmp

# Set correct permissions to use non root user
WORKDIR /home/node/

# Copy over the template files
COPY ./ ./

# This ordering means the npm installation is cached for the outer function handler.
RUN npm install --production \
  && mkdir -p /home/node/function \
  && chown node:node -R /home/node

USER node

HEALTHCHECK --interval=1s CMD [ -e /tmp/.lock ] || exit 1

CMD ["fwatchdog"]
