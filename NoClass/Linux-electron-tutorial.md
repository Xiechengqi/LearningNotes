# Linux electron 学习记录
## electron

* Electron（ 原名为 Atom Shell ）是 GitHub 开发的一个开源库，可以通过使用 HTML、CSS、JavaScript 创建跨平台的桌面应用
* 它允许使用 Node.js（作为后端）和 Chromium（作为前端）完成桌面 GUI 应用程序的开发
* 一个基础的 Electron 包含三个文件：package.json（元数据）、main.js（代码）和 index.html（图形用户界面）
* Electron 对应不同平台可执行文件：Windows 中为 electron.exe、macOS 中为 electron.app、Linux 中为 electron 
* 开发者可以自行添加标志、自定义图标、重命名或编辑 Electron 可执行文件
* Electron 现已被多个开源 Web 应用程序用于前端与后端的开发，著名项目包括 GitHub 的 Atom、GitHub 客户端、WhatsApp Windows 及 Mac 客户端和微软的 Visual Studio Code
* Electron 使用 web 页面作为它的 GUI，所以你能把它看作成一个被 JavaScript 控制的，精简版的 Chromium 浏览器

> 由于 Electron 本身就是基于 Chromium 的，所以它的基础大小就已经很大了，应该 50M 左右
