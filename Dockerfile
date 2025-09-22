# Use Debian-based OpenJDK
FROM openjdk:17-jdk-slim

WORKDIR /opt/traccar

# copy only what we need (we created a reduced folder)
COPY tracker-server.jar ./
COPY conf ./conf
COPY lib ./lib
COPY web ./web
COPY templates ./templates
COPY schema ./schema

# expose web UI port and typical device ports (container-only)
EXPOSE 8082
EXPOSE 5000-5150

# Default PORT environment for Render (use 8082 inside container unless overridden)
ENV PORT=8082

# Replace any <port>...</port> occurrences with the runtime $PORT (safe for web UI).
# Then start Traccar.
CMD sh -c "sed -i -E 's|<port>[0-9]+</port>|<port>'$PORT'</port>|g' conf/traccar.xml || true \
  && java -jar tracker-server.jar conf/traccar.xml"
