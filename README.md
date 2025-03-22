```markdown
# Інсталяція Jenkins на Ubuntu

Цей репозиторій містить скрипт для автоматичної інсталяції Jenkins на сервері Ubuntu. Використовуючи наведені команди, ви зможете налаштувати Jenkins з нуля та налаштувати SSH для доступу до репозиторіїв на GitHub.

## Кроки інсталяції

### 1. Оновлення системи
Для початку оновіть пакети на вашому сервері:
```bash
sudo apt update
```

### 2. Встановлення Apache2
Встановіть вебсервер Apache2:
```bash
sudo apt install -y apache2
```

### 3. Додавання ключа Jenkins та репозиторію
Завантажте та додайте ключ для Jenkins:
```bash
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
```
Додайте репозиторій Jenkins в списки джерел:
```bash
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
```

### 4. Оновлення та встановлення Jenkins
Оновіть списки пакетів і встановіть Jenkins:
```bash
sudo apt-get update
sudo apt-get install -y jenkins
```

### 5. Встановлення Java
Jenkins вимагає Java для роботи. Встановіть OpenJDK 17:
```bash
sudo apt install -y fontconfig openjdk-17-jre
java -version
```

### 6. Налаштування Jenkins
Увімкніть та запустіть Jenkins, а також перевірте його статус:
```bash
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins
```

### 7. Отримання початкового пароля адміністратора
Отримайте початковий пароль для входу в Jenkins:
```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

### 8. Створення SSH-ключа
Створіть SSH-ключ для з'єднання з GitHub:
```bash
sudo ssh-keygen -t ed25519 -f /root/.ssh/id_ed25519 -C "vsevolod0823@gmail.com"
```

### 9. Перегляд публічного та приватного ключа
Перегляньте публічний та приватний ключі:
```bash
sudo cat /root/.ssh/id_ed25519.pub
sudo cat /root/.ssh/id_ed25519
```

### 10. Налаштування SSH для Jenkins
Створіть папку `.ssh` для користувача Jenkins та скопіюйте туди SSH-ключі:
```bash
sudo mkdir -p /var/lib/jenkins/.ssh/
sudo cp /root/.ssh/id_ed25519 /var/lib/jenkins/.ssh/
sudo cp /root/.ssh/id_ed25519.pub /var/lib/jenkins/.ssh/
sudo chown -R jenkins:jenkins /var/lib/jenkins/.ssh/
sudo chmod 700 /var/lib/jenkins/.ssh/
sudo chmod 600 /var/lib/jenkins/.ssh/id_ed25519
sudo chmod 644 /var/lib/jenkins/.ssh/id_ed25519.pub
```

### 11. Додавання GitHub до відомих хостів
Додайте GitHub до відомих хостів для Jenkins:
```bash
sudo -u jenkins ssh-keyscan -t ed25519 github.com >> /var/lib/jenkins/.ssh/known_hosts
```

### 12. Перезапуск Jenkins
Перезапустіть Jenkins для застосування змін:
```bash
sudo systemctl restart jenkins
```

### 13. Налаштування прав доступу
Додайте користувача Jenkins до списку користувачів без пароля для виконання команд:
```bash
#jenkins ALL=(ALL) NOPASSWD: ALL
```
