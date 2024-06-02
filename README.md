# Introduction
This repository contains the necessary files and instructions to set up DokuWiki on an Ubuntu Server 22.04(and higher) using Docker. DokuWiki is a simple to use and highly versatile Open Source wiki software that doesn't require a database.

## Prerequisites

Before you begin, ensure you have the following installed on your Ubuntu server:

- [Docker](https://docs.docker.com/engine/install/ubuntu/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Table of Contents

1. [Introduction](#introduction)
2. [Prerequisites](#prerequisites)
3. [Setup Instructions](#setup-instructions)
    - [Clone the Repository](#clone-the-repository)
    - [Docker Compose File](#docker-compose-file)
    - [Setup Script](#setup-script)
4. [Running the Setup Script](#running-the-setup-script)
5. [Accessing DokuWiki](#accessing-dokuwiki)
6. [Managing Your Wiki](#managing-your-wiki)
7. [Configuration and Customization](#configuration-and-customization)
8. [Troubleshooting](#troubleshooting)

## Setup Instructions

### Clone the Repository

First, clone this repository to your local machine:

```sh
git clone https://github.com/rmlrkh/DokuWiki-Ubuntu-Server-Setup
```

### Docker Compose File

Create a **docker-compose.yml** file with the following content:
```
version: '3.7'

services:
  dokuwiki:
    image: bitnami/dokuwiki:latest
    ports:
      - "8080:8080"
    volumes:
      - 'dokuwiki_data:/bitnami/dokuwiki'
    environment:
      - ALLOW_EMPTY_PASSWORD=yes

volumes:
  dokuwiki_data:
    driver: local

```

### Setup Script

1. Create a **setup.sh** script with the following content:

```
#!/bin/bash

echo "Setting up DokuWiki server..."

# Check if Docker is installed
if ! [ -x "$(command -v docker)" ]; then
  echo 'Error: Docker is not installed.' >&2
  exit 1
fi

# Check if Docker Compose is installed
if ! [ -x "$(command -v docker-compose)" ]; then
  echo 'Error: Docker Compose is not installed.' >&2
  exit 1
fi

# Start the DokuWiki server
docker-compose up -d

echo "DokuWiki is up and running on http://localhost:8081"

```

2. Make the **setup.sh** script executable:

```
chmod +x setup.sh
```

### Running the Setup Script

To set up your DokuWiki server, simply run the setup script:
```
./setup.sh
```

### Accessing DokuWiki

Open your web browser and navigate to http://localhost:8080. You should see the DokuWiki homepage.

### Managing Your Wiki

Adding Pages

• Log in to DokuWiki: Open your web browser and navigate to the URL where your DokuWiki instance is running (e.g., http://localhost:8080). Log in using the credentials you set up during the installation.

• Edit a Page: Navigate to the section where you want to add a new page. Click the "Edit this page" button (usually a pencil icon) next to the section title.

• Create the Page: Start typing the content of your new page using DokuWiki markup syntax. You can find documentation on DokuWiki markup here.

• Save the Page: Once you're done adding content, click the "Save" button to save your changes.

Organizing Content

• Create Namespace and Pages: DokuWiki uses a hierarchical structure called namespaces to organize pages. You can create namespaces by using the / character in the page name. For example, namespace/page_name.

• Linking Pages: Use double square brackets [[ ]] to create links to other pages within your wiki. For example, [[namespace/page_name]]. If the page doesn't exist, DokuWiki will create a link to it, allowing you to easily create new pages as needed.

• Index and Navigation: DokuWiki automatically generates an index of pages based on the namespace structure. You can navigate through the wiki by clicking on links or using the search functionality.

• Templates: You can create page templates to standardize the layout and content of pages. Templates are stored in the data/pages/_template directory.

• Plugins: DokuWiki has a wide range of plugins available to extend its functionality. You can find and install plugins from the official DokuWiki plugin repository.

### Configuration and Customization
For further customization and configuration of your DokuWiki instance, refer to the official [DokuWiki documentation](https://www.dokuwiki.org/manual).

## Troubleshooting

### Docker Not Installed

If you encounter errors indicating that Docker is not installed, you can install Docker by following these steps:

1. Update your existing list of packages:
```
sudo apt update
```
2. Install Docker using the convenience script provided by Docker:
```
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```
3. Verify that Docker is installed correctly by running:
```
sudo docker run hello-world
```
### Docker Compose Not Installed
1. If Docker Compose is not installed, install it using the following command:
```
sudo curl -L "https://github.com/docker/compose/releases/download/$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r .tag_name)/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```
2. Apply executable permissions to the binary:
```
sudo chmod +x /usr/local/bin/docker-compose
```
3. Verify that Docker Compose is installed correctly by checking the version:
```
docker-compose --version
```
### If you are using a firewall (UFW, Fail2ban)

To allow port 8080 through the firewall using **ufw**, follow these steps:

1. Allow port 8080:
```
sudo ufw allow 8080
```
2. Reload ufw to apply the changes:
```
sudo ufw reload
```

For **fail2ban**, ensure the following:

1. Open the jail.local configuration file:
```
sudo nano /etc/fail2ban/jail.local
```
2. Add or modify the [DEFAULT] section to include the allowed port:
```
[DEFAULT]
ignoreip = 127.0.0.1/8 ::1
bantime  = 600
findtime  = 600
maxretry = 5
port = 8080
```
3. Restart fail2ban to apply the changes:
```
sudo systemctl restart fail2ban
```
With this setup, you now have a personal wiki up and running on your Ubuntu server. You can customize and expand your wiki as needed.

