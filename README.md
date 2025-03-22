# Jenkins

Цей репозиторій містить конфігурації та налаштування для розгортання Jenkins.

## Вимоги

- **ОС:** Ubuntu/Debian (або інша, що підтримує Jenkins)
- **Docker** (якщо використовуєте контейнеризовану версію)
- **Java 11+** (Jenkins вимагає JDK 11 або новішу версію)

## Встановлення

### 1. Встановлення Jenkins

Виконайте такі команди, щоб встановити Jenkins на Ubuntu:

```bash
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
echo "deb http://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list
sudo apt update
sudo apt install jenkins
```

Запустіть Jenkins та перевірте статус:

```bash
sudo systemctl start jenkins
sudo systemctl status jenkins
```

### 2. Встановлення через Docker

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
