# Personal Docker Compose Collection

## Project Overview

This repository contains a collection of Docker Compose setups for various self-hosted services. These are my personalized configurations, tailored to my specific needs and environment. While they can serve as a template or starting point, you will likely need to adjust them.

## Directory Structure

The services are organized into the following directories:

*   **`man/`**: Contains Docker Compose configurations for management and core infrastructure services.
    *   Key Services: Watchtower (automatic updates), Docker Socket Proxy, AdGuard Home (network-wide ad-blocking), AdGuard Home Sync, PostgreSQL (database).
*   **`media/`**: Contains Docker Compose configurations for media-related services.
    *   Key Services: Watchtower, Docker Socket Proxy, Homepage (dashboard), Sabnzbd (usenet downloader), Plex (media server), Tautulli (Plex monitoring), Sonarr (TV show management), Radarr (movie management), Bazarr (subtitle management).
*   **`webtop/`**: Contains the Docker Compose configuration for a Webtop (KDE) instance, providing a remote desktop environment accessible via a web browser.

## General Usage Instructions

To use these Docker Compose files:

1.  **Clone the repository:**
    ```bash
    git clone <repository-url>
    cd <repository-name>
    ```

2.  **Navigate to a service directory:**
    ```bash
    cd man/  # or media/, or webtop/
    ```

3.  **Create Environment Files (if applicable):**
    Some services require environment variables to be set. For example, the `postgres` service in `man/docker-compose.yml` requires `${PGDB}`, `${PGUSER}`, and `${PGPASS}`. Create a `.env` file in the respective directory to define these variables:
    ```env
    # Example for man/.env
    PGDB=mydatabase
    PGUSER=myuser
    PGPASS=mypassword
    ```
    Review each `docker-compose.yml` file for environment variables denoted by `${VARIABLE_NAME}` and set them accordingly in your `.env` file.

4.  **Customize Configurations:**
    Before deploying, review and customize the `docker-compose.yml` files to match your environment. Pay attention to:
    *   **Volumes:** Update host paths for volume mounts (e.g., `/config/adguard`, `/data/Movies`).
    *   **Ports:** Change ports if they conflict with existing services on your host.
    *   **Environment Variables:** Adjust `PUID`, `PGID`, `TZ` (Timezone), and other service-specific environment variables.

5.  **Start the services:**
    ```bash
    docker-compose up -d
    ```

6.  **Stop the services:**
    ```bash
    docker-compose down
    ```

## License

This project is licensed under the terms of the GPL-3.0 License. See the `LICENSE` file for more details.

## Disclaimer

These are my personal configurations and are provided as-is. You should use them at your own risk. Ensure you understand the services you are deploying and the configurations you are applying. Always back up your data and review security best practices for any self-hosted service.
---
*This README was enhanced by an AI assistant.*
