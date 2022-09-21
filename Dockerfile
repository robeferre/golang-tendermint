FROM golang:1.15 AS build-env
ADD . /src
WORKDIR /src
RUN  go build  && \
     git clone https://github.com/tendermint/tendermint.git && \
     cd tendermint \
     make install && \
     make build


# final stage
FROM alpine
WORKDIR /app
COPY --from=build-env /src/goapp /app/
ENTRYPOINT ./goapp
