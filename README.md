# 🏗️ Inception - Containerized Infrastructure

| Attribute | Description |
| :--- | :--- |
| **Project Goal** | Set up a multi-service web infrastructure using Docker Compose. |
| **Focus** | System Administration, Containerization, Networking, TLS/SSL. |
| **System** | Virtual Machine (VM). |
| **Tools** | Docker Compose, Dockerfiles, NGINX, MariaDB, WordPress. |

## 🎯 Mandatory Requirements

[cite_start]This infrastructure must be built inside a Virtual Machine using Docker Compose[cite: 740, 797]. [cite_start]All configurations must be handled within the project; using ready-made images from DockerHub is forbidden (except for the base OS)[cite: 805, 804].

### 1. Services and Components

[cite_start]The infrastructure must consist of the following three services, each running in a dedicated container[cite: 799, 806]:

* [cite_start]**NGINX:** Must serve as the sole entry point[cite: 839]. [cite_start]Must be configured with **TLSv1.2 or TLSv1.3 only**[cite: 807, 839].
* [cite_start]**WordPress:** Must run only with **php-fpm** (without NGINX)[cite: 808].
* [cite_start]**MariaDB:** Must run only as the database service (without NGINX)[cite: 809].

### 2. Networking and Volumes

* [cite_start]All containers must be built from either **Alpine or Debian** base images[cite: 800].
* [cite_start]All services must be connected via a single **docker-network**[cite: 812]. [cite_start]Using `network: host` or `--link` is forbidden[cite: 820].
* [cite_start]Two dedicated **Docker volumes** are required[cite: 810, 811]: one for the WordPress database and one for the WordPress website files.
* [cite_start]Containers must **restart automatically** in case of a crash[cite: 813].

### 3. Configuration and Security

* [cite_start]**Customization:** You must write your own `Dockerfiles` for each service[cite: 802].
* [cite_start]**Access:** The infrastructure must be accessible via your configured domain name: `[your_login].42.fr`[cite: 833].
* [cite_start]**Entry Point:** NGINX must be the only service accessible from the outside, only via **port 443**[cite: 839].
* [cite_start]**Security:** Passwords must **not** be present in the `Dockerfiles`[cite: 836]. [cite_start]The use of **environment variables** is mandatory[cite: 837].
* **Prohibited Hacks:** Containers must not be started with endless loops (`tail -f`, `sleep infinity`, etc.). [cite_start]Read about PID 1 best practices[cite: 822, 824, 826].

## 🛠️ How to Run

1.  [cite_start]Place all configuration files (including `docker-compose.yml`, `.env`, and service Dockerfiles) in the required **`srcs` folder**[cite: 741, 881].
2.  [cite_start]Use the **Makefile** located at the root to build and run the entire application[cite: 742, 743].

---
[cite_start]*(Note: This README is based solely on the mandatory requirements listed in the provided 'inception.pdf.pdf' [cite: 795, 796, 806, 839]).*
