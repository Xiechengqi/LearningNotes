# Nginx 配置开启 https

## 证书

## 

## Q&A


、**`配置 http 自动跳转 https`**

、**`自建 https 证书在 chrome 浏览器中提示“不安全”`**
解决：
默认情况下生成的证书一旦选择信任，在 Edge, Firefox 等浏览器都显示为安全，但是Chrome仍然会标记为不安全并警告拦截，这是因为 Chrome 需要证书支持扩展 Subject Alternative Name, 因此生成时需要特别指定 SAN 扩展并添加相关参数

、**``**

、**``**
1、**`网页中存在不带 https 的资源，比如 http 协议的 js 、 css 或图片，那么访问这个 https 页面，某些浏览器（比如IE）就会发出警告，提示页面中存在不安全的内容，并且不会加载这些 http 协议的资源，导致页面错乱等问题`**

解决：
1. 将 http 资源链接全部更换成相对地址。比如 `http://xiechengqi.top/img/logo.png` 修改成 `/img/logo.png`
2. 将全部 http 换成 https


