# Jenkins

Цей репозиторій містить конфігурації та налаштування для розгортання Jenkins.

## Вимоги

- **ОС:** Ubuntu/Debian (або інша, що підтримує Jenkins)
- **Docker** (якщо використовуєте контейнеризовану версію)
- **Java 11+** (Jenkins вимагає JDK 11 або новішу версію)

## Встановлення

### 1. Автоматизоване встановлення

Виконайте скрипт `install_jenkins.sh`, щоб автоматично встановити Jenkins:

```bash
chmod +x install_jenkins.sh
./install_jenkins.sh
```

### 2. Ручне встановлення

Якщо потрібно встановити Jenkins вручну, виконайте наступні команди:

```bash
sudo apt update
sudo apt install -y apache2

sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install -y jenkins

sudo apt install -y fontconfig openjdk-17-jre
java -version

sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins

sudo cat /var/lib/jenkins/secrets/initialAdminPassword

sudo ssh-keygen -t ed25519 -f /root/.ssh/id_ed25519 -C "vsevolod0823@gmail.com"

sudo cat /root/.ssh/id_ed25519.pub
sudo cat /root/.ssh/id_ed25519

sudo mkdir -p /var/lib/jenkins/.ssh/
sudo cp /root/.ssh/id_ed25519 /var/lib/jenkins/.ssh/
sudo cp /root/.ssh/id_ed25519.pub /var/lib/jenkins/.ssh/
sudo chown -R jenkins:jenkins /var/lib/jenkins/.ssh/
sudo chmod 700 /var/lib/jenkins/.ssh/
sudo chmod 600 /var/lib/jenkins/.ssh/id_ed25519
sudo chmod 644 /var/lib/jenkins/.ssh/id_ed25519.pub
sudo -u jenkins ssh-keyscan -t ed25519 github.com >> /var/lib/jenkins/.ssh/known_hosts
sudo systemctl restart jenkins

#jenkins ALL=(ALL) NOPASSWD: ALL
```

### 3. Встановлення через Docker

Якщо використовуєте Docker, запустіть контейнер з Jenkins:

```bash
docker run -d --name jenkins -p 8080:8080 -p 50000:50000 jenkins/jenkins:lts
```

## Конфігурація

1. Відкрийте браузер і перейдіть за адресою: `http://localhost:8080`
2. Використовуйте команду для отримання пароля адміністратора:

```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

3. Завершіть початкове налаштування через веб-інтерфейс.

## Плагіни

Рекомендується встановити такі плагіни:

- **Pipeline** - для роботи з CI/CD
- **Git** - для інтеграції з Git-репозиторіями
- **Docker Pipeline** - якщо використовуєте Docker

## Використання

- Додайте нову задачу (job) через "New Item"
- Налаштуйте підключення до репозиторію та автоматичне розгортання
- Використовуйте Webhook для тригерингу збірок

## Автор

**Всеволод** - веброзробник, DevOps-ентузіаст.
