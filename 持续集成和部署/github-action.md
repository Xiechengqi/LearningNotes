# Github Actions 学习

> * [Github 官方文档](https://help.github.com/en/articles/workflow-syntax-for-github-actions)
> * [Github Actions 入门教程 - 阮一峰](http://www.ruanyifeng.com/blog/2019/09/getting-started-with-github-actions.html)
> * [Github awesome actions 项目](https://github.com/sdras/awesome-actions)
> * [Github Actions 通过 SSH 自动备份到代码托管网站](https://blog.csdn.net/z_johnny/article/details/104061608)
> * [GitHub action for deploying a project to GitHub pages](https://github.com/JamesIves/github-pages-deploy-action)

## 基础知识

Github Action 其实就是开启了一个

## 定时任务

## 手动点击 star 触发 CI

## 使用 ssh 私钥同步到 github、gitee 等远程仓库


github action 设置 serects `SSH_PRIVATE_KEY` 时必须完全复制粘贴 `~/.ssh/id_rsa` 内容！！！

```
# 包括 BEGIN 和 END 行
-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEAnu9WNZm7OiWK6gPuThOyB8YwX8qu/lHbndxOxuLQ3x8Gqar4
4UzR1xM+MNQV87XOYcjsPPqdcrOPGSbO+UPZhlQWpbj4RVrTGqxOHuACnkQaGZq6
EZwPx7OW1H6vjEgXF/AiSFwpT85VM9RYBGy2yzvB4Y1Zqlys11JaU6C5pfLDK/nc
ughNMuloWCV2L7SPGsiv6RTP4y/fwQEb9wzbBqNnWXAYg7LsyPSqT7TINm1wXK3H
Rq9ehOOlIBuKnQTv1/HWhcPcRUx+uI/lObhYO4QSky84uKG6FEa0yX7rAM405R1t
66zC/GG4u6yrFeh5J3AlaopNxfOhLw5+8H2TDwIDAQABAoIBAGjYWBWZ6WHNXFtN
5onJAluQiV7X1SLeGzODHtCi1ckqrXmF2RK/W3o3LoKFlkmkOJZXNkhvxyfgfdjI
uibDdJ7hn+MJJ3aRGMvyuMIzYmbHZDRZ1r9BJUPHHAvn2qR+9gULm4ICkhocciZz
wPCCSv+81wSU+36gDkEpCX87etyWQ5dz7gJRKP9RJFN4FwVmQX56LqH7fbwrujkK
i7oho3ynsHjZ3H0NJldkRx3cTMCi4YYYkHNllymFKNgW9HFUto2s56SwwfUYrJm2
CWzhWdeDuKjO6tzun9qiSY60Cvj/bA6Yz6qp3iE0gE6pHg3Bd4FAbnknvIUYwJrF
SmLdk0kCgYEA0Ez+CA1xJuPZW/R3eaNKIpJLLq3wRkzxuKEiREeTwbKeJowSr702
ruB/YBzkmGLt4jJdL1+wHWvUxiZtTT24XpV/PJjGfVySiyqtlrzqhofP5TvSPpyj
p3IqLWByXxeXbCZbM8F382/c172PtW/3cvRdHq/9LT6Mv8Cu3HFDZWUCgYEAw1Rr
eFupX7VFbRCC1Zg4qsNEnH+ENI67US3+kJnVhb9SOwmYbQcE1yCGNc9ujpk9YHVH
fSrcroxmMReDixO/OurTcaUT7W0gDM0CIJ1qGrg2bFqLpUAoUsEsncOBuJ4KGdax
nDVpj1AnDRyuzKq8GOCVaUl4EQodf5g6BulEmWMCgYB+lOsi1ZhXe8sQ2GTqZFKe
46wQd981uXiDLFh4ic6+vN7iqeiJJ0Dd0MtXCvfXqvbIqLZ8HXgWyPqKV7vAXqt1
vv+NQYINmH3tWEgY/EDA9DNgKJRBPEsvbG85GA0owFtie4Sc1Qshwm7AJA/6wEnt
b5ZPGb+PCR3bQSqCB8pfCQKBgBWceoOHiLbZJIRLpl4hiGuETUwPY7446Iqzzw2K
p7azmdKEXkP52dQ/efnsKGxIkhzg/PbhTidVy1y1IE278pV/M8PIIutK/pfL+udG
411vcj4MypSPA6ccTmZqIikd+zoeoeoJktNTZ+6wdLqaTVNnTcCna0xfVSIv4oOv
PXLHAoGAbHhfgp84L7TshqgqTfUxj4TefJNeDYMYwUvGSp/bH9ihFbyfbzHLJIzv
11HLqV4B7tvhjJUCmNXk7fMvqyEmSjTq6lxFfAcnvsr9m4cHQKOkkss7pi2ebHvq
q42u0qujrrwJruRyAmPIDS5+BzrvUxcMmQW+ktG5lAfcdKLE0+4=
-----END RSA PRIVATE KEY-----
```
