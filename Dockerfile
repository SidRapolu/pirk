# Use the official Golang image as a build environment
FROM golang:1.18-alpine AS build-env
WORKDIR /app

# Copy the Go Modules files
COPY go.mod .
COPY go.sum .
RUN go mod download

# Copy the source code
COPY . .

# Build the Go app
RUN go build -o main cmd/api/main.go

# Start a new container for the runtime environment
FROM alpine:latest
WORKDIR /app
COPY --from=build-env /app/main /app/main

# Expose port 8080 to the outside world
EXPOSE 8080

# Command to run the executable
CMD ["./main"]
