# 🐳 Inception

### **A complete containerized WordPress infrastructure using Docker, featuring NGINX, MariaDB, and WordPress running in isolated containers with SSL encryption**


## Video Demo
[Coming Soon]




## Features
- **Containerization**: Fully Dockerized infrastructure with custom images
- **Security**: NGINX with TLSv1.2/1.3 SSL encryption
- **Persistence**: Docker volumes for database and WordPress files
- **Isolation**: Each service runs in its own container
- **High Availability**: Automatic container restart on crash


## Infrastructure Overview
<img width="506" alt="Capture_dcran_2022-07-19__16 24 51" src="https://github.com/user-attachments/assets/18c82947-d104-4ed1-9acf-6c53ce45c96a" />
---

## Quick Setup

1. **Launch Infrastructure**
   ```bash
   make
   ```

2. **Access WordPress**
   ```
   https://ybarbot.42.fr
   ```

---

## Technical Details

<details>
  <summary><strong>Container Architecture</strong></summary>

### NGINX Container
- Debian based
- SSL/TLS encryption
- Port 443 only
- Reverse proxy configuration

### WordPress Container
- PHP-FPM configuration
- WordPress core files
- Custom PHP optimizations
- Volume mounted content

### MariaDB Container
- Secure database configuration
- Persistent data storage
- Custom user setup
- Optimized for WordPress

</details>

<details>
  <summary><strong>Volume Configuration</strong></summary>

- **/wordpress**: Site files and uploads
- **/database**: MariaDB data files
- Location: /home/ybarbot/data

</details>

<details>
  <summary><strong>Network Details</strong></summary>

- Internal Docker network
- Container isolation
- NGINX as sole entry point
- Inter-container communication

</details>

<details>
  <summary><strong>Security Features</strong></summary>

- Environment variables
- Docker secrets support
- No hardcoded credentials
- SSL/TLS encryption
- Custom user configuration

</details>
