# Use Debian-based OpenJDK
FROM openjdk:17-jdk-slim

WORKDIR /opt/traccar

# copy only what we need
COPY tracker-server.jar ./
COPY conf ./conf
COPY lib ./lib
COPY web ./web
COPY templates ./templates
COPY schema ./schema

# Ensure logs folder exists
RUN mkdir -p /opt/traccar/logs

# Expose web UI port (Render will inject $PORT)

# Default PORT environment
ENV PORT=10000

# Start Traccar, overriding web.port via system property

CMD echo "Render assigned port: $PORT" && \
    java -Dweb.port=$PORT -Dweb.address=0.0.0.0 -jar tracker-server.jar conf/traccar.xml




