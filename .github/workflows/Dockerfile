# Dockerfile
FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine AS base
WORKDIR /app

# Copy the published output
COPY dist/linux-x64/migratrix-agent .

# Make executable
RUN chmod +x migratrix-agent

# Create non-root user
RUN adduser -D -s /bin/sh agent && chown agent:agent migratrix-agent

# Switch to non-root user
USER agent

# Set entrypoint
ENTRYPOINT ["./migratrix-agent"]

# Default command (can be overridden)
CMD ["--help"]