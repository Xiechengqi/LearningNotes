# Grafana

> * **[Grafana Dashboard](https://grafana.com/grafana/dashboards)**
> * **[Prometheus Config](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#%3Cscrape_config%3E)**

## 目录

* [exporter](#exporter)

## exporter

### node

* node_exporter: https://github.com/prometheus/node_exporter
* Grafana dashboard: https://grafana.com/grafana/dashboards/1860

* Prometheus.yml

``` shell
- job_name: node
    static_configs:
      - targets: ['localhost:9100']
```

### redis

> * [promethus 监控 Redis](https://www.cnblogs.com/xiao987334176/p/12101496.html)

* redis_exporter: https://github.com/oliver006/redis_exporter
* Grafana dashboard: https://grafana.com/grafana/dashboards/763

* Prometheus.yml

``` shell
# 添加单个 redis 实例
scrape_configs:
  - job_name: redis_exporter
    static_configs:
    - targets: ['<<REDIS-EXPORTER-HOSTNAME>>:9121']

# 添加多个 redis 实例
scrape_configs:
  ## config for the multiple Redis targets that the exporter will scrape
  - job_name: 'redis_exporter_targets'
    static_configs:
      - targets:
        - redis://first-redis-host:6379
        - redis://second-redis-host:6379
        - redis://second-redis-host:6380
        - redis://second-redis-host:6381
    metrics_path: /scrape
    relabel_configs:
      - source_labels: [__address__]
        target_label: __param_target
      - source_labels: [__param_target]
        target_label: instance
      - target_label: __address__
        replacement: <<REDIS-EXPORTER-HOSTNAME>>:9121

  ## config for scraping the exporter itself
  - job_name: 'redis_exporter'
    static_configs:
      - targets:
        - <<REDIS-EXPORTER-HOSTNAME>>:9121
```

### nginx

* nginx exporter: https://github.com/nginxinc/nginx-prometheus-exporter
* Grafana Dashboard: 

### windows

* windows_exporter: 
* Grafana Dashboard: https://grafana.com/grafana/dashboards/10467
* Prometheus.yml

``` shell

```





### mysql

