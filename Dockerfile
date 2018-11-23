FROM golang:alpine

COPY . /code
RUN cd /code && go build main.go

FROM alpine

COPY --from=0 /code/main /go-test
COPY --from=0 /code/homepage.html /homepage.html
RUN chmod u+x /go-test
RUN apk add ca-certificates --no-cache
RUN update-ca-certificates
CMD ["./go-test"]