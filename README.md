# Jenkins

Цей репозиторій містить конфігурації та налаштування для автоматизації CI/CD за допомогою Jenkins.

## Вимоги

- Jenkins >= 2.x
- Docker (опціонально для контейнеризованого запуску)
- Плагіни Jenkins (за потреби)

## Структура репозиторію

```
Jenkins/
│── jobs/            # Конфігурації Jenkins Jobs
│── pipelines/       # Скрипти декларативних конвеєрів
│── config/          # Файли конфігурації
│── plugins.txt      # Список необхідних плагінів
│── docker-compose.yml # Запуск через Docker
│── scripts/         # Скрипти для автоматизації
```

## Використання

1. Клонувати репозиторій:
   ```sh
   git clone https://github.com/sevii-ia/Jenkins.git
   cd Jenkins
   ```

2. Якщо використовується Docker, запустити:
   ```sh
   docker-compose up -d
   ```

3. Увійти в Jenkins через браузер за адресою:
   ```
   http://localhost:8080
   ```
   При першому запуску потрібно ввести початковий пароль із логів контейнера:
   ```sh
   docker exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword
   ```

4. Встановити необхідні плагіни з файлу `plugins.txt`:
   ```sh
   cat plugins.txt | xargs -n 1 jenkins-plugin-cli --install
   
