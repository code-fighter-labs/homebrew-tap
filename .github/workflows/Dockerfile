# Dockerfile
FROM alpine:latest

# Install any runtime dependencies
RUN apk add --no-cache ca-certificates

# Create non-root user
RUN adduser -D -s /bin/sh agent

# Copy the binary (built in GitHub Actions)
COPY migratrix /usr/local/bin/migratrix
RUN chmod +x /usr/local/bin/migratrix

# Switch to non-root user
USER agent

# Set entrypoint
ENTRYPOINT ["migratrix"]

# Default command (can be overridden)
CMD ["--help"]