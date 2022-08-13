# syntax=docker/dockerfile:1

FROM golang:1.16-alpine

WORKDIR /app

COPY go.mod ./
RUN go mod download

ADD build/page.html ./
ADD build/secret.html ./
ADD build/images ./images
COPY *.go ./

RUN go build -o /final-task

EXPOSE 8080

CMD [ "/final-task" ]
