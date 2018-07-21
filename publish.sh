# 下载主题
git clone https://github.com/probberechts/hexo-theme-cactus.git --depth=1 themes/cactus

# 替换主题配置文件
cp ./_theme_config.yml ./themes/cactus/_confit.yml

# 静态构建并部署
hexo g -d
