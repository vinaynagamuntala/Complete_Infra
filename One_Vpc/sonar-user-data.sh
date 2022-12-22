#!/bin/bash
amazon-linux-extras install java-openjdk11 -y
cd /opt 
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.9.10.61524.zip
unzip sonarqube-8.9.10.61524.zip
mv sonarqube-8.9.10.61524 sonarqube 
chmod -R 775 sonarqube
useradd sonaradmin
chown -R sonaradmin:sonaradmin /opt/sonarqube
su - sonaradmin -c "/opt/sonarqube/bin/linux-x86-64/sonar.sh start"