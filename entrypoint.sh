#!/bin/sh

#Default configuration
#https://de.minecraft.wiki/w/Server.properties
CONFIG_FILE="./server.properties"

# Function to override a property
set_prop() {
  KEY="$1"
  VALUE="$2"

  if grep -q "^${KEY}=" "${CONFIG_FILE}"; then
    sed "s|^${KEY}=.*|${KEY}=${VALUE}|" "$CONFIG_FILE" > /tmp/temp.properties
    cp /tmp/temp.properties "$CONFIG_FILE"
  else
    echo "${KEY}=${VALUE}" >> "$CONFIG_FILE"
  fi
}

# Override the properties
[ -n "${MAX_PLAYERS}" ] && set_prop "max-players" "${MAX_PLAYERS}"
[ -n "${DIFFICULTY}" ] && set_prop "difficulty" "${DIFFICULTY}"

# Start the server
# java -Xmx4G -Xms4G -jar minecraft_server.26.1.2.jar nogui
#https://www.minecraft.net/de-de/download/server
exec java -Xmx${JAVA_MAX_RAM} -Xms${JAVA_MIN_RAM} -jar server.jar --nogui