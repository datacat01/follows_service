FROM elixir:1.9.4 as builder
ENV VERSION 0.1.0

WORKDIR /opt/server-builder/
COPY . /opt/server-builder/

RUN mix local.hex --force && mix local.rebar --force
RUN MIX_ENV=prod mix do deps.get --only prod, deps.compile --force
RUN mix deps.clean mime --build
RUN MIX_ENV=prod mix distillery.release --env=prod
RUN APP_NAME="follows_service" && \
    mkdir -p /opt/${APP_NAME} && \
    MIX_ENV=prod mix distillery.release --verbose && \
    cp /opt/server-builder/_build/prod/rel/follows_service/releases/0.1.0/follows_service.tar.gz /opt/${APP_NAME} && \
    cd /opt/${APP_NAME} && \
    tar -xzf ${APP_NAME}.tar.gz && \
    rm ${APP_NAME}.tar.gz
RUN rm -rf /opt/server-builder



# FROM alpine:3.9

# ENV LANG C.UTF-8 \
#   REFRESHED_AT 2019-09-14-1 \
#   TERM xterm \
#   DEBIAN_FRONTEND noninteractive

# ENV REPLACE_OS_VARS=true \
#   HOSTNAME=${HOSTNAME} \
#   ERL_CRASH_DUMP_SECONDS=10 \
#   HEART_BEAT_TIMEOUT=30 \
#   HEART_KILL_SIGNAL=SIGABRT \
#   HEART_NO_KILL=0 \
#   HEART_COMMAND=reboot

# RUN apk add --update \
#   bash \
#   openssl

# COPY --from=builder /opt/server /usr/local/bin/server
# WORKDIR /usr/local/bin/server/bin
# USER default
# EXPOSE 8081 50051

# CMD /bin/bash
