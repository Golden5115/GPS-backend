# Use Debian-based OpenJDK
FROM openjdk:17-jdk-slim

WORKDIR /opt/traccar

# Copy only what we need
COPY tracker-server.jar ./
COPY conf ./conf
COPY lib ./lib
COPY web ./web
COPY templates ./templates
COPY schema ./schema

# Ensure logs folder exists
RUN mkdir -p /opt/traccar/logs

# Default PORT (Render will override this)
ENV PORT=10000

# Start Traccar, binding to Render’s assigned port
CMD echo "Starting Traccar on port $PORT" && \
    java -Dweb.port=$PORT -Dweb.address=0.0.0.0 -jar tracker-server.jar conf/traccar.xml
