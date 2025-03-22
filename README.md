# Jenkins

Цей репозиторій містить інструкції для налаштування Jenkins на сервері Ubuntu за допомогою скрипта `install_jenkins.sh`.

## Встановлення Jenkins

1. **Оновлення системи:**
   Спочатку потрібно оновити список доступних пакетів:
   ```bash
   sudo apt update
   ```

2. **Встановлення Apache2:**
   Для налаштування необхідно встановити Apache2:
   ```bash
   sudo apt install -y apache2
   ```

3. **Додавання ключа Jenkins:**
   Завантажте і додайте ключ для перевірки пакету Jenkins:
   ```bash
   sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
     https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
   ```

4. **Додавання репозиторію Jenkins:**
   Додайте репозиторій Jenkins до вашої системи:
   ```bash
   echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
     https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
     /etc/apt/sources.list.d/jenkins.list > /dev/null
   ```

5. **Оновлення списку пакетів:**
   Оновіть список доступних пакетів після додавання репозиторію:
   ```bash
   sudo apt-get update
   ```

6. **Встановлення Jenkins:**
   Встановіть Jenkins на ваш сервер:
   ```bash
   sudo apt-get install -y jenkins
   ```

7. **Встановлення необхідних бібліотек:**
   Для коректної роботи Jenkins потрібно встановити Java:
   ```bash
   sudo apt install -y fontconfig openjdk-17-jre
   java -version
   ```

8. **Запуск та налаштування Jenkins:**
   Налаштуйте Jenkins для автоматичного запуску при старті системи:
   ```bash
   sudo systemctl enable jenkins
   sudo systemctl start jenkins
   sudo systemctl status jenkins
   ```

9. **Отримання початкового паролю адміністратора:**
   Для доступу до Jenkins спочатку потрібно ввести початковий пароль адміністратора:
   ```bash
   sudo cat /var/lib/jenkins/secrets/initialAdminPassword
   ```

## Налаштування SSH для Jenkins

1. **Створення SSH ключа:**
   Згенеруйте новий SSH ключ для користувача `root`:
   ```bash
   sudo ssh-keygen -t ed25519 -f /root/.ssh/id_ed25519 -C "vsevolod0823@gmail.com"
   ```

2. **Перегляд публічного та приватного ключа:**
   Перегляньте публічний та приватний ключ:
   ```bash
   sudo cat /root/.ssh/id_ed25519.pub
   sudo cat /root/.ssh/id_ed25519
   ```

3. **Копіювання SSH ключа для Jenkins:**
   Створіть директорію `.ssh` для Jenkins та скопіюйте ключі:
   ```bash
   sudo mkdir -p /var/lib/jenkins/.ssh/
   sudo cp /root/.ssh/id_ed25519 /var/lib/jenkins/.ssh/
   sudo cp /root/.ssh/id_ed25519.pub /var/lib/jenkins/.ssh/
   sudo chown -R jenkins:jenkins /var/lib/jenkins/.ssh/
   sudo chmod 700 /var/lib/jenkins/.ssh/
   sudo chmod 600 /var/lib/jenkins/.ssh/id_ed25519
   sudo chmod 644 /var/lib/jenkins/.ssh/id_ed25519.pub
   ```

4. **Додавання GitHub до відомих хостів Jenkins:**
   Додайте GitHub до списку відомих хостів:
   ```bash
   sudo -u jenkins ssh-keyscan -t ed25519 github.com >> /var/lib/jenkins/.ssh/known_hosts
   ```

5. **Перезапуск Jenkins:**
   Перезапустіть Jenkins, щоб застосувати зміни:
   ```bash
   sudo systemctl restart jenkins
   ```

## Налаштування прав доступу

Щоб дозволити Jenkins працювати без введення пароля при виконанні команд з привілеями, додайте наступний рядок до файлу `/etc/sudoers`:
```bash
jenkins ALL=(ALL) NOPASSWD: ALL
```

Тепер Jenkins повністю налаштовано та готовий до використання!
