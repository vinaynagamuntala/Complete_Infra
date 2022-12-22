#!/bin/bash
yum update -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd
# wget https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz
# tar -xvzf node_exporter-1.5.0.linux-amd64.tar.gz
# sudo rm -rf node_exporter-1.5.0.linux-amd64.tar.gz
# sudo touch /etc/systemd/system/node_exporter.service
# sudo su -
# echo "[Unit]
# Description=Prometheus server
# Documentation=https://prometheus.io/docs/introduction/overview/
# After=network-online.target

# [Service]
# User=root
# Restart=on-failure

# ExecStart=/home/ec2-user/node_exporter-1.5.0.linux-amd64/node_exporter

# [Install]
# WantedBy=multi-user.target" > /etc/systemd/system/node_exporter.service
# sudo systemctl daemon-reload
# sudo systemctl start node_exporter