## Ansible 句子解析

#### replace - 修改配置文件

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

#### yum - 安装软件

```yaml
- name: "Install Docker"
  yum:
    name: docker
    state: latest
    update_cache: yes	
```

#### service - 服务

```yaml
- name: start and enable grafana-server.
  service:
  	name: grafana-server
  	state: started
  	enabled: yes
```

#### register - 存储执行操作返回结果

```yaml
- shell: "echo test2"
  register: shellreturn
```

#### notify、handlers - 触发

```yaml
- name: Copy Nginx.conf
  template:
  	src: ./nginx.conf.j2 dest=/etc/nginx/nginx.conf  owner=root group=root mode=0644
  notify:
     Restart Nginx Service
handlers:
  - name: Restart Nginx Service
    service: name=nginx state=restarted
```

```yaml
- name: Checking if this version of Ansible has a fix for the hostname module
  set_fact:
    hostname_module_fixed: "{{ ansible_version['full'] | version_compare('2.5', '>=') }}"
- name: Checking if this version of RHEL is affected by the hostname problem
  set_fact:
    rhel75: "{{ (ansible_distribution == 'RedHat') and (ansible_distribution_version | version_compare('7.5', '>=')) }}"
- name: Setting hostname and DNS domain
  hostname: name="{{ new_fqdn }}"
  when: not rhel75 or hostname_module_fixed
```

#### firewalld - 防火墙

```yaml
# 开防火墙
- name: Open Firewall for HTTPD
  firewalld: 
  	 port=80/tcp
  	 permanent=yes
  	 state=enabled
  	 immediate=yes
  	 zone=public
```

#### seboolean - SELinux

```
- name: HTTPD SELinux Configurations
  seboolean:
    name: httpd_can_network_connect
    state: yes
    persistent: yes
```

#### user - 用户

```
- name: Create Git User
  user: 
  	name="{{ git_user }}"
```

uri - 验证 url 是否连通

``` yaml
- name: verify | 查看验证url状态。
  uri: "url={{ deploy_verify_url }}"
  register: curl_result
  until: curl_result.status == 200
  retries: 20
  delay: 3
  changed_when: false
  check_mode: no
  become: no
  when: deploy_verify_uri != ""
```

#### stat - 检查文件

``` yaml
- name: Check if docker-compose file is already.
  stat: path={{ docker_exec_path }}
  register: docker_compose_result
```

