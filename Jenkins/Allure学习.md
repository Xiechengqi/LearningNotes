# Allure 学习

## 目录

* **`[首页趋势图生成](首页趋势图生成)`**





## 首页趋势图生成

* 使用 `allure generate target/surefire-reports -c -o allure-reports` 默认不会有趋势图
* 需要将上一次生成的 `allure-reports/history` 目录下所有文件拷贝到 `target/surefire-reports` 目录下
* 之后再执行 `allure generate target/surefire-reports -c -o allure-reports` ，生成的静态报告就会有趋势图

