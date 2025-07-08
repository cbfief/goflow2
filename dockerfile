# Use the official Golang image for building
FROM golang:1.22 AS builder

# Set working directory
WORKDIR /app

# Download and build the app
RUN git clone https://github.com/openobserve/goflow2.git . \
    && go build -o goflow2 ./cmd/goflow2

# Create a minimal final image
FROM debian:bullseye-slim

# Install any runtime dependencies (none needed here usually)
WORKDIR /app

# Copy binary from builder stage
COPY --from=builder /app/goflow2 .

# Expose any needed ports here if applicable (not required for HTTP client mode)
ENTRYPOINT ["./goflow2"]
