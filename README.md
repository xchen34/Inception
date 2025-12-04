# 🏗️ Inception - Containerized Infrastructure

| Attribute | Description |
| :--- | :--- |
| **Project Goal** | Set up a multi-service web infrastructure using Docker Compose. |
| **Focus** | System Administration, Containerization, Networking, TLS/SSL. |
| **System** | Virtual Machine (VM). |
| **Tools** | Docker Compose, Dockerfiles, NGINX, MariaDB, WordPress. |

## 🎯 Mandatory Requirements

This infrastructure must be built inside a Virtual Machine using Docker Compose.  
All configurations must be handled within the project; using ready-made images from DockerHub is forbidden (except for the base OS).

### 1. Services and Components

The infrastructure must consist of the following three services, each running in a dedicated container:

* **NGINX:** Acts as the sole entry point, with TLSv1.2 or TLSv1.3 only.
* **WordPress:** Must run only with **php-fpm** (no NGINX inside this container).
* **MariaDB:** Acts as the database service (no NGINX inside this container).

### 2. Networking and Volumes

* All containers must be built from **Alpine or Debian** base images.
* All services must communicate through a single **docker-network**.  
  (`network: host` or `--link` is forbidden.)
* Two dedicated **Docker volumes** are required:
  - one for the MariaDB database  
  - one for WordPress files
* Containers must **restart automatically** on crash.

### 3. Configuration and Security

* You must write your own **Dockerfiles** for every service.
* Infrastructure must be accessible via:  
  **`[your_login].42.fr`**
* NGINX must be the only entry point from the outside, listening only on **port 443**.
* Passwords must **not** appear inside Dockerfiles.  
  Use **environment variables** and mounted secret files instead.
* Containers must **not** start with endless loops (`tail -f`, `sleep infinity`, etc.).

---

## 📁 Mandatory Structure and Security

### 1. `srcs` Folder (Project Configuration)

All configuration files must be inside the `srcs` folder:

* `docker-compose.yml`
* `.env`
* all service `Dockerfile`s
* config scripts

### 2. `secrets` Folder (Credentials)

The `secrets` folder must be located at the project root.

It contains sensitive files such as:

* `db_password.txt`
* `wp_admin_pass.txt`

This folder **must be in `.gitignore`**, so no credentials ever reach GitHub.

---

## 🛠️ How to Run

1. Place all configuration files inside the `srcs` folder.
2. Ensure the `secrets` folder (with password files) is present at the project root.
3. Use the root-level **Makefile** to build and run the entire stack:

```
make
```
