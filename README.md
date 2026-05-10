# Jenkins

Repository with scripts and instructions for installing and configuring Jenkins on an Ubuntu server.

## Table of Contents

- [Overview](#overview)
- [Requirements](#requirements)
- [Installation](#installation)
- [Access Jenkins](#access-jenkins)
- [SSH Configuration for Jenkins](#ssh-configuration-for-jenkins)
- [Sudo Permissions](#sudo-permissions)
- [Troubleshooting](#troubleshooting)
- [License](#license)

## Overview

This project helps automate the setup of Jenkins on Ubuntu using the `install_jenkins.sh` script.  
It installs required packages, adds the official Jenkins repository, installs Jenkins, configures Java, starts the Jenkins service, and prepares SSH access for Jenkins.

## Requirements

- Ubuntu server
- User with `sudo` privileges
- Internet access
- Open port `8080`
- Git installed, if Jenkins will work with GitHub repositories

## Installation

Clone the repository:

```bash
git clone https://github.com/sevii-ia/Jenkins.git
cd Jenkins
````

Make the installation script executable:

```bash
chmod +x install_jenkins.sh
```

Run the script:

```bash
./install_jenkins.sh
```

The script performs the following actions:

```bash
sudo apt update
sudo apt install -y apache2
sudo apt install -y fontconfig openjdk-17-jre
```

It also adds the Jenkins Debian repository, installs Jenkins, enables the service, and starts it.

## Access Jenkins

After installation, Jenkins is available at:

```text
http://localhost:8080
```

If Jenkins is installed on a remote server, use:

```text
http://SERVER_IP:8080
```

Get the initial administrator password:

```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

Use this password in the Jenkins web interface to complete the first-time setup.

## SSH Configuration for Jenkins

Generate an SSH key:

```bash
sudo ssh-keygen -t ed25519 -f /root/.ssh/id_ed25519 -C "your-email@example.com"
```

Create the Jenkins SSH directory:

```bash
sudo mkdir -p /var/lib/jenkins/.ssh/
```

Copy SSH keys:

```bash
sudo cp /root/.ssh/id_ed25519 /var/lib/jenkins/.ssh/
sudo cp /root/.ssh/id_ed25519.pub /var/lib/jenkins/.ssh/
```

Set ownership and permissions:

```bash
sudo chown -R jenkins:jenkins /var/lib/jenkins/.ssh/
sudo chmod 700 /var/lib/jenkins/.ssh/
sudo chmod 600 /var/lib/jenkins/.ssh/id_ed25519
sudo chmod 644 /var/lib/jenkins/.ssh/id_ed25519.pub
```

Add GitHub to known hosts:

```bash
sudo -u jenkins ssh-keyscan -t ed25519 github.com >> /var/lib/jenkins/.ssh/known_hosts
```

Restart Jenkins:

```bash
sudo systemctl restart jenkins
```

## Sudo Permissions

To allow Jenkins to run commands with elevated privileges without a password, add this line to `/etc/sudoers`:

```bash
jenkins ALL=(ALL) NOPASSWD: ALL
```

Recommended way to edit sudoers:

```bash
sudo visudo
```

## Useful Commands

Check Jenkins status:

```bash
sudo systemctl status jenkins
```

Start Jenkins:

```bash
sudo systemctl start jenkins
```

Stop Jenkins:

```bash
sudo systemctl stop jenkins
```

Restart Jenkins:

```bash
sudo systemctl restart jenkins
```

Enable Jenkins on boot:

```bash
sudo systemctl enable jenkins
```

## Troubleshooting

If Jenkins is not available in the browser, check the service:

```bash
sudo systemctl status jenkins
```

Check whether port `8080` is open:

```bash
sudo ss -tulnp | grep 8080
```

If using a cloud server, make sure port `8080` is allowed in the firewall or security group.

For Ubuntu firewall:

```bash
sudo ufw allow 8080
sudo ufw reload
```

## Project Structure

```text
.
├── install_jenkins.sh
├── README.md
├── LICENSE
├── Jenkins_18/
├── Jenkins_AWS/
├── Jenkins_Cloud/
├── Jenkins_ansible/
├── Jenkins_page/
└── Jenkinsfile_zabbix/
```

## License

This project is licensed under the MIT License.

See the [LICENSE](LICENSE) file for more information.
