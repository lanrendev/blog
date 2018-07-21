# 下载主题
if [ ! -d 'themes/cactus' ]; then
    git clone https://github.com/probberechts/hexo-theme-cactus.git --depth=1 themes/cactus
else
    git pull
fi

# 替换主题配置文件
cp ./_theme_config.yml ./themes/cactus/_config.yml

# 静态构建并部署到 gh-pages
if hash hexo 2>/dev/null; then
    hexo g -d
else
    npm install hexo-cli -g
    hexo g -d
fi

# 源文件提交到 master 分支
git add .
message="New post: $(date +%Y-%m-%d\ %H:%M:%S)"
echo $message
git commit -m "$message"
git push origin master