## GitLab 设置邮件找回密码


### 一、修改 `/etc/gitlab/gitlab.rb` 文件

``` shell
# 在 `/etc/gitlab/gitlab.rb` 中添加如下
gitlab_rails['time_zone'] = 'Asia/Shanghai' 

## 配置发信人
gitlab_rails['gitlab_email_enabled'] = true 
gitlab_rails['gitlab_email_from'] = 'xiecq@paraview.cn' 
gitlab_rails['gitlab_email_display_name'] = 'Paraview Gitlab' 

## 配置 smtp 邮件服务器
gitlab_rails['smtp_enable'] = true 
gitlab_rails['smtp_address'] = "smtp.exmail.qq.com" 
gitlab_rails['smtp_port'] = 465 
gitlab_rails['smtp_user_name'] = "xiecq@paraview.cn" 
gitlab_rails['smtp_password'] = "Xcq1234567" 
gitlab_rails['smtp_domain'] = "paraview.cn" 
gitlab_rails['smtp_authentication'] = "login" 
gitlab_rails['smtp_enable_starttls_auto'] = true
gitlab_rails['smtp_tls'] = true
```

### 二、重新加载 GitLab 配置

``` shell
$ gitlab-ctl reconfigure
```

#### 三、测试发邮件

``` shell
$ gitlab-rails console
-------------------------------------------------------------------------------------
 GitLab:       12.0.3 (08a51a9db93)
 GitLab Shell: 9.3.0
 PostgreSQL:   10.7
-------------------------------------------------------------------------------------
Loading production environment (Rails 5.1.7)
irb(main):001:0> Notify.test_email('xiechengqiemail@163.com', '测试邮件标题', '测试邮件正文').deliver_now

Notify.test_email('xiechengqiemail@163.com','title','content').deliver_now
Notify#test_email: processed outbound mail in 3.1ms
Sent mail to xiechengqiemail@163.com (1886.5ms)
Date: Tue, 29 Sep 2020 07:20:04 +0000
From: Paraview Gitlab <xiecq@paraview.cn>
Reply-To: Paraview Gitlab <noreply@b6282582bbe5>
To: xiechengqiemail@163.com
Message-ID: <5f72e024e6f39_30893f8da88d39b438211@b6282582bbe5.mail>
Subject: title
Mime-Version: 1.0
Content-Type: text/html;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html><body><p>content</p></body></html>

=> #<Mail::Message:69877334329360, Multipart: false, Headers: <Date: Tue, 29 Sep 2020 07:20:04 +0000>, <From: Paraview Gitlab <xiecq@paraview.cn>>, <Reply-To: Paraview Gitlab <noreply@b6282582bbe5>>, <To: xiechengqiemail@163.com>, <Message-ID: <5f72e024e6f39_30893f8da88d39b438211@b6282582bbe5.mail>>, <Subject: title>, <Mime-Version: 1.0>, <Content-Type: text/html; charset=UTF-8>, <Content-Transfer-Encoding: 7bit>, <Auto-Submitted: auto-generated>, <X-Auto-Response-Suppress: All>>
irb(main):002:0>
```

