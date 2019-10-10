https://prometheus.io/download/#node_exporter

Download archive:
wget https://github.com/prometheus/node_exporter/releases/download/v0.18.1/node_exporter-0.18.1.linux-amd64.tar.gz
tar xvfz node_exporter-0.18.1.linux-amd64.tar.gz 
mv node_exporter-0.18.1.linux-amd64/ node_exporter

Create unit:
vim /etc/systemd/system/node_exporter.service

[Unit]
Description= Node Exporter

[Service]
User=root
ExecStart=/<path_to_node_exporter>/node_exporter

[Install]
WantedBy=default.target

Reload/start units:
systemctl daemon-reload
systemctl start node_exporter.service

