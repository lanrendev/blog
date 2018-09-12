---
title: 解决Nuxt项目中发生在服务端的请求丢失Cookie的问题
date: 2018-09-13 00:21:18
tags:
- Vue
- Nuxt
- axios
- Cookie
- SSR
categories:
- 笔记
---

## 问题描述

### 现象

产品和测试的同学一并提来 bug，内容为：

> 退出登录，然后刷新「我的页」，会自动重新登录成功，而且登录的不是自己的账号。

### 找原因

一开始只有产品提这个问题，我不信，甚至很不情愿接受这样的 bug。后来小组内的开发兄弟也偶现了这个 bug，我还是不信，认为这是不可能发生的事情。再到后来，超过两位测试同学提了这个问题，引起了我的重视，因为这个问题相当严重，如果不解决将不堪设想。

最后经过开发兄弟的提醒，再加上去 Nuxt 开源项目的 issues 翻了翻，发现了问题的原因。

因为发生在服务端的异步请求也需要 Cookie 信息，但是此时又没有客户端的 Cookie 自动发送，于是我们增加了一个 middleware，取名为 `bind-headers.js`，代码如下：

```javascript
export default function ({ req, app }) {
    if (process.server && req.headers.cookie) {
        app.$ajax.defaults.headers.common['cookie'] = req.headers.cookie
        app.$ajax.defaults.headers.common['user-agent'] = req.headers['user-agent']
    }
}
```

其中 `$ajax` 就是封装好的 `axios`，我们为了方便使用，把它挂在了 app 对象上面。

问题就出在这里，cookie 已经成了 axios 的公共 header，如果没有新的值覆盖，这里会把上一次的 cookie 带到下一个请求，从而导致了请求的数据错误而且诡异（拿到了他人的用户信息）。

## 解决方法

想了很久没有找到合适的解决办法，在 Nuxt 开源项目的 issues 里面找到了同样问题的记录，里面提供了两种方法：

### 方法一

改造开始的那个 middleware

```javascript
export default function ({ req, app }) {
    app.$ajax.defaults.headers.common = {}
    if (process.server && req.headers.cookie) {
        app.$ajax.defaults.headers.common['cookie'] = req.headers.cookie
        app.$ajax.defaults.headers.common['user-agent'] = req.headers['user-agent']
    }
}
```

但是下面有人反馈说这个方法还是有同样的问题，目前尚未得到回复。

### 方法二

使用 [nuxt-community/axios-module](https://github.com/nuxt-community/axios-module)，这个是官方社区的模块。

我决定采用方法二处理此问题。一来此模块考虑到了此问题并且解决了这个问题，二来此模块对 axios 做了更加完美和实用的封装，做成了配置化的形式，如果无法造出更好的轮子，找一个成熟的轮子是最佳选择了。
