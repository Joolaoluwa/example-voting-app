FROM node:18-slim@sha256:f9ab18e354e6855ae56ef2b290dd225c1e51a564f87584b9bd21dd651838830e

# add curl for healthcheck, tini as init process, and create non-root user
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl tini && \
    rm -rf /var/lib/apt/lists/* \
    && groupadd -g 1010 appGroup \
    && useradd --no-log-init -u 1010 -g appGroup -m -s /usr/sbin/nologin appUser

WORKDIR /usr/local/app

# have nodemon available for local dev use (file watching)
RUN npm install -g nodemon

# install dependencies as root so npm ci can write to the workdir,
# then move node_modules out to /node_modules before dropping privileges
COPY package*.json ./

RUN npm ci && \
    npm cache clean --force && \
    mv /usr/local/app/node_modules /node_modules && \
    chown -R appUser:appGroup /usr/local/app

COPY --chown=appUser:appGroup . .

# drop to non-root for runtime
USER appUser

ENV PORT=80
EXPOSE 80

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["node", "server.js"]
