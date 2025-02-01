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
