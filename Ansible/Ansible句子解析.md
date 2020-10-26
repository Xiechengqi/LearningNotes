## Ansible 句子解析

#### 修改配置文件

```yaml
# install grafana
- name: Setup grafana server config file.
  replace: path=/etc/grafana/grafana.ini regexp={{ item.r }} replace={{ item.s }}
  with_items:
    - { r: ";http_port = 3000", s: "http_port = {{ grafana_http_port }}"}
    - { r: ";admin_user = admin", s: "admin_user = {{ grafana_admin_user }}"}
    - { r: ";admin_password = admin", s: "admin_password = {{ grafana_admin_password }}"}
   
- name: Check for cloud.cfg
  stat: path=/etc/cloud/cloud.cfg
  register: cloud_cfg
- name: Prevent cloud-init updates of hostname/fqdn (if applicable)
  lineinfile:
    dest: /etc/cloud/cloud.cfg
    state: present
    regexp: "{{ item.regexp }}"
    line: "{{ item.line }}"
  with_items:
    - { regexp: '^ - set_hostname', line: '# - set_hostname' }
    - { regexp: '^ - update_hostname', line: '# - update_hostname' }
  when: cloud_cfg.stat.exists == True
```

#### 安装软件

```yaml
- name: "Install Docker"
  yum:
    name: docker
    state: latest
    update_cache: yes	
```

#### 启动服务

```yaml
- name: start and enable grafana-server.
  service: name=grafana-server state=started enabled=yes
```

#### 存储执行操作返回结果

```yaml
- shell: "echo test2"
  register: shellreturn
```

#### 触发重启

```yaml
- name: Copy Nginx.conf
  template: src=./nginx.conf.j2 dest=/etc/nginx/nginx.conf  owner=root group=root mode=0644
  notify:
     Restart Nginx Service
handlers:
  - name: Restart Nginx Service
    service: name=nginx state=restarted
```

```
# Ansible 2.5 fixed the hostname module for RHEL 7.5:  https://github.com/ansible/ansible/pull/31839
- name: Checking if this version of Ansible has a fix for the hostname module
  set_fact:
    hostname_module_fixed: "{{ ansible_version['full'] | version_compare('2.5', '>=') }}"

# The hostname module does not work on RHEL version 7.5 with Ansible versions < 2.5
- name: Checking if this version of RHEL is affected by the hostname problem
  set_fact:
    rhel75: "{{ (ansible_distribution == 'RedHat') and (ansible_distribution_version | version_compare('7.5', '>=')) }}"

- name: Setting hostname and DNS domain
  hostname: name="{{ new_fqdn }}"
  # Use the hostname module when not on RHEL 7.5 or on the version of Ansible that fixed the hostname module.
  when: not rhel75 or hostname_module_fixed
```

#### 防火墙

```yaml
- name: Open Firewall for HTTPD
  firewalld: 
  	port=80/tcp
  	permanent=yes
  	state=enabled
  	immediate=yes
  	zone=public
```

#### SELinux

```
- name: HTTPD SELinux Configurations
  seboolean:
    name: httpd_can_network_connect
    state: yes
    persistent: yes
```

#### 新增用户

```
- name: Create Git User
  user: 
  	name="{{ git_user }}"
```

