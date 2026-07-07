# Minecraft Server
# Description
This is a Project to set up, run and maintain your personal Minecraft server. It includes installation, instructions, configuration guidance, server startup procedures and backup management workflows.

# Table of contents
- Prerequisites
- Quickstart
- Usage
- Testing

# Prerequisites
- Docker Engine should be installed and running.
- You should be confortable using a terminal/shell and basic Docker concepts.
- Download the mincraft installer.

# Quickstart
- Navigate to the parent directory whre you want to have the Project.

``` cd /path/to/your/Project```

- Clone the repository from GitHub

``` git clone https://github.com/NicoMeyerDev/Mincraft-Server ```

- Switch in the cloned Project directory

``` cd mincraft_server ```

- Copy the example environment file to the directory

``` cp example.env .env ```

- Run Docker server

``` docker compose up -d ```

- Starte the game and log in using a Java Minecraft client.
- Select Multiplayer
- Click Direct connenction
- Enter the server IP and Port

# Usage
This configuration uses a standard Minecraft server running version 26.2 As the environment is intended primarily for documentation and testing purposes, and because system resources are limited, the server is configured with a minimum of 1 GB and a maximum of 2 GB of RAM. These values can be adjusted, if required, by modifying the corresponding variables in the .env file.

The primary configuration file for a multiplayer server is server.properties, which defines the server's core settings. Some of these settings can be overridden through environment variables specified in the .env file. To apply these overrides, the relevant environment variables must be processed within entrypoint.sh, which then updates the corresponding values in server.properties before the server starts.

# Testing 

## Prerequisites
- Docker container is running (`docker compose up -d`)
- Python 3 installed (for MCStatus)

## Steps

### 1. Verify config overrides
Check that environment variables from `.env` are correctly applied to `server.properties`:

    cat config/server.properties

Confirm `max-players` and `difficulty` match the values set in `.env`.

### 2. Verify restart persistence
Restart the container and confirm the world and configuration are not reset:

    docker compose restart mc-server
    docker compose logs -f mc-server

Look for `Preparing level "world"` without `No existing world data, creating new world`.

### 3. Verify connection with MCStatus
Set up a Python virtual environment and install MCStatus:

    python -m venv venv
    source venv/bin/activate
    python3 -m pip install mcstatus

Enable query mode in `config/server.properties`:

    enable-query=true

Restart the container, then run:

    mcstatus localhost:8888 ping
    mcstatus localhost:8888 status
    mcstatus localhost:8888 query

### 4. Verify auto-restart on failure
`docker stop`/`docker kill` are treated as intentional user actions by Docker and will **not** trigger the `unless-stopped` restart policy. To simulate a real crash, kill the Java process running inside the container instead:

    docker exec mc-server kill -9 1

Then confirm the container restarted automatically:

    docker compose ps -a

Container should show as running again due to `restart: unless-stopped`.

### 5. (Optional) Connect with Java Minecraft Client
- Launch Minecraft, select **Multiplayer** → **Direct Connection**
- Enter server IP and port `8888`