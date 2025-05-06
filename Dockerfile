FROM golang:1.21-bullseye

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    ffmpeg \
    gcc \
    sqlite3 \
    libsqlite3-dev \
    && rm -rf /var/lib/apt/lists/*

# Set up working directory
WORKDIR /app

# Copy the entire repository
COPY . .

# Make sure CGO is enabled
ENV CGO_ENABLED=1
ENV PYTHONUNBUFFERED=1

# Create required directories
RUN mkdir -p whatsapp-bridge/store

# Install Go dependencies and build WhatsApp bridge
RUN cd whatsapp-bridge && \
    go mod tidy && \
    go mod download && \
    CGO_ENABLED=1 go build -o whatsapp-bridge main.go

# Install Python dependencies
RUN cd whatsapp-mcp-server && \
    pip3 install --no-cache-dir -r requirements.txt

# Create a startup script with proper process management
RUN echo '#!/bin/bash\n\
 echo "Starting WhatsApp Bridge..."\n\
 cd /app/whatsapp-bridge && CGO_ENABLED=1 ./whatsapp-bridge &\n\
 BRIDGE_PID=$!\n\
 echo "WhatsApp Bridge started with PID: $BRIDGE_PID"\n\
 \n\
 # Wait for bridge to initialize\n\
 echo "Waiting for WhatsApp Bridge to initialize (10 seconds)..."\n\
 sleep 10\n\
 \n\
 # Check if bridge is still running\n\
 if ! kill -0 $BRIDGE_PID 2>/dev/null; then\n\
   echo "ERROR: WhatsApp Bridge failed to start. Check the logs above."\n\
   exit 1\n\
 fi\n\
 \n\
 echo "Starting Python MCP Server..."\n\
 cd /app/whatsapp-mcp-server && python3 main.py\n\
 ' > /app/start.sh && chmod +x /app/start.sh

# Expose the port that the Python MCP server runs on (default is 3000)
EXPOSE 3000

# Start both services using the script
CMD ["/app/start.sh"]
