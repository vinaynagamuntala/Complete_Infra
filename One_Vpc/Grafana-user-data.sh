#!/bin/bash
wget https://dl.grafana.com/oss/release/grafana-9.3.0-1.x86_64.rpm
sudo yum install grafana-9.3.0-1.x86_64.rpm -y
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable grafana-server.service
sudo /bin/systemctl start grafana-server.service
cd /tmp/
wget https://github.com/prometheus/prometheus/releases/download/v2.40.4/prometheus-2.40.4.linux-amd64.tar.gz
tar -xvzf prometheus-2.40.4.linux-amd64.tar.gz
rm -rf prometheus-2.40.4.linux-amd64.tar.gz
cd prometheus-2.40.4.linux-amd64
nohup ./prometheus &
# sudo touch /etc/systemd/system/prometheus.service
# sudo su -
# echo "[Unit]
# Description=Prometheus server
# Documentation=https://prometheus.io/docs/introduction/overview/
# After=network-online.target

# [Service]
# User=root
# Restart=on-failure

# ExecStart=/home/ec2-user/prometheus-2.40.4.linux-amd64/prometheus --config.file=/home/ec2-user/prometheus-2.40.4.linux-amd64/prometheus.yml

# [Install]
# WantedBy=multi-user.target" > /etc/systemd/system/prometheus.service
# sudo systemctl daemon-reload
# sudo systemctl start prometheus