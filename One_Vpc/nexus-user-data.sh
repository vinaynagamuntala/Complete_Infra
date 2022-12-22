#!/bin/bash
sudo yum update -y
sudo yum install wget -y
sudo yum install java-1.8.0-openjdk.x86_64 -y
cd /opt/
sudo wget http://download.sonatype.com/nexus/3/nexus-3.19.0-01-unix.tar.gz
sudo tar -xvf nexus-3.19.0-01-unix.tar.gz
sudo mv nexus-3.19.0-01 nexus
sudo adduser nexus
sudo chown -R nexus:nexus /opt/nexus
sudo chown -R nexus:nexus /opt/sonatype-work
sudo vi /opt/nexus/bin/nexus.rc
# run_as_user="nexus"
sudo vi /opt/nexus/bin/nexus.vmoptions
# -Xms512m
# -Xmx512m
# -XX:MaxDirectMemorySize=512m
sudo ln -s /opt/nexus/bin/nexus /etc/init.d/nexus
sudo chkconfig --add nexus
sudo chkconfig --levels 345 nexus on
sudo service nexus start
# tail -f /opt/sonatype-work/nexus3/log/nexus.log
http://public_dns_name:8081
sudo cat /opt/sonatype-work/nexus3/admin.password