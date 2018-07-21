# 下载主题
git clone https://github.com/probberechts/hexo-theme-cactus.git --depth=1 themes/cactus

# 替换主题配置文件
cp ./_theme_config.yml ./themes/cactus/_confit.yml

# 静态构建并部署到 gh-pages
hexo g -d

# 源文件提交到 master 分支
git add .
date='$(date +%Y-%m-%d\ %H:%M:%S)'
git commit -m 'New post: $date'
git push origin master