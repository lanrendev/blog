# Blog of lanrendev

懒人听书前端开发博客，用于记录踩过的坑，分享技术内容和学习成果。

## Steps to publish a post

1.把分支 clone 下来

```sh
git clone git@github.com:lanrendev/blog.git
```

2.安装依赖

```sh
yarn

# or

npm install
```

3.准备本地环境

```sh
npm install hexo-cli -g
```

4.创建新的文章

```sh
# title name => 文章标题，也是文件名
hexo new post 'title name'
```

5.书写文章内容

> 新创建的文件在 `./source/_posts/` 目录下。

6.发布文章

```sh
./publish.sh
```

## Attension

**所有的操作都在 `master` 分支下进行**