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
EXPOSE 8082

# Default PORT environment
ENV PORT=8082

# Start Traccar, overriding web.port via system property
CMD sh -c "echo Starting Traccar on port $PORT && java -jar tracker-server.jar conf/traccar.xml"



