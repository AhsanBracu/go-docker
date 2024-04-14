FROM golang:1.21.9-alpine3.19 as builder
WORKDIR /build
COPY go.mod go.sum ./
RUN go mod download
COPY . . 
ENV CGO_ENABLED="0" \
    GOOS="linux"
RUN  go build ./main.go

FROM alpine:3.19 as Final
ENV PORT=4321 
LABEL version="1.0"
WORKDIR /app/
COPY --from=builder /build/main .
CMD ["./main"]

# FROM golang:1.21.9-alpine3.19
# ENV PORT="4321"
# ENV CGO_ENABLED="0"
# ENV GOOS="linux"
# LABEL version="1.0"
# WORKDIR /app
# COPY . . 
# RUN  go build -o main .
# CMD [ "go", "run", "main.go" ]