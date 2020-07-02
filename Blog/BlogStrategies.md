## 利用GitHub Pages搭建个人Blog

本文内容根据网友**[Runyang Jiang](https://r1v3rj1s.github.io/)**的[Blog](https://r1v3rj1s.github.io/categories/Blog/) 整理。


### 目标和策略 

[原文](https://r1v3rj1s.github.io/2019/08/13/Deploying-a-Hexo-NexT-Blog-1/)

Hexo静态博客框架+NexT主题，搭建与部署在GitHub Pages上


### 先决要求和初始化配置

[原文](https://r1v3rj1s.github.io/2019/08/13/Deploying-a-Hexo-NexT-Blog-2/)


#### 配置Git
Run the following command under local git folder ( here is yubin@M720-ubuntu:~/GitRepos$ ):
``` bash
$ git clone git@github.com:BinYuOnCa/binyuonca.github.com.git Homepage
Cloning into 'Homepage'...
remote: Enumerating objects: 10, done.
remote: Counting objects: 100% (10/10), done.
remote: Compressing objects: 100% (6/6), done.
remote: Total 10 (delta 0), reused 0 (delta 0), pack-reused 0
Receiving objects: 100% (10/10), done.

$ git checkout -b pg-source
Switched to a new branch 'pg-source'
$ git branch
  master
* pg-source
$ git push --set-upstream origin pg-source
Total 0 (delta 0), reused 0 (delta 0)
remote: 
remote: Create a pull request for 'pg-source' on GitHub by visiting:
remote:      https://github.com/BinYuOnCa/binyuonca.github.com/pull/new/pg-source
remote: 
To github.com:BinYuOnCa/binyuonca.github.com.git
 * [new branch]      pg-source -> pg-source
Branch 'pg-source' set up to track remote branch 'pg-source' from 'origin'.
$ 
```


#### 初始化Hexo
**安装Nodes&npm**
[ref: nodejs installation on Linux ](https://github.com/nodejs/help/wiki/Installation#how-to-install-nodejs-via-binary-archive-on-linux)

- Unzip the binary archive to any directory you wanna install Node, I use /usr/local/lib/nodejs
```bash 
$sudo mkdir -p /usr/local/lib/nodejs
$sudo tar -xJvf node-$VERSION-$DISTRO.tar.xz -C /usr/local/lib/nodejs 
```

- Set the environment variable ~/.profile, add below to the end
```bash
# Nodejs
VERSION=v12.18.2
DISTRO=linux-x64
export PATH=/usr/local/lib/nodejs/node-$VERSION-$DISTRO/bin:$PATH
```
- Refresh profile and test installation
```bash 
$ . ~/.profile
$ node -v
v12.18.2
$ npm -v
6.14.5
$ npx -v
6.14.5
```

**安装Hexo命令行**
``` bash
$ sudo npm install hexo-cli -g
WARN engine fsevents@2.1.3: wanted: {"node":"^8.16.0 || ^10.6.0 || >=11.0.0"} (c/usr/local/bin/hexo -> /usr/local/lib/node_modules/hexo-cli/bin/hexo
/usr/local/lib

npm WARN optional Skipping failed optional dependency /hexo-cli/chokidar/fsevents:
npm WARN notsup Not compatible with your operating system or architecture: fsevents@2.1.3
```
Verifying it's installed successfully:
```bash
$hexo -v 
hexo-cli: 3.1.0
os: Linux 4.15.0-108-generic linux x64
node: 12.18.2
v8: 7.8.279.23-node.39
uv: 1.38.0
zlib: 1.2.11
brotli: 1.0.7
ares: 1.16.0
modules: 72
nghttp2: 1.41.0
napi: 6
llhttp: 2.0.4
http_parser: 2.9.3
openssl: 1.1.1g
cldr: 37.0
icu: 67.1
tz: 2019c
unicode: 13.0

```

**创建Hexo框架源文件包，并将源文件移至本地个人主页仓库文件夹**
```bash
$ hexo init blog_source # 创建Hexo框架源文件包
$ mv blog_source/* 个人主页仓库文件夹 # 将源文件移至本地个人主页仓库文件夹
$ ll blog_source/
total 60
drwxr-xr-x  2 yubin yubin  4096 Jul  1 16:29 ./
drwxr-xr-x 14 yubin yubin 40960 Jul  1 16:25 ../
-rw-r--r--  1 yubin yubin    65 Jul  1 16:25 .gitignore
$ rm -rf blog_source 

```
**本地以调试模式**
在本地以调试模式尝试运行Hexo，如果成功的话在浏览器内输入http://localhost:4000应该会出现Hexo Landscape主题的博客页面
```bash
$ cd 个人主页仓库文件夹
$ npm install
$ hexo server --debug # 如果成功出现页面，即可按ctrl+C退出
$ hexo clean # 删除临时信息
```


#### 初始化NexT

Run the following command in homepage folder:

```bash
$ git clone https://github.com/theme-next/hexo-theme-next themes/next
$ cd themes/next
$ rm -rf .git* # 移除Git相关信息
```
Note: 由于我们相当于是在一个Git仓库中又拉取了一个Git仓库，因此如果此时上传我们的本地文件到远程仓库服务器会提醒你要不要把NexT主题文件夹作为submodule上传进行管理，但由于submodule本身管理比较麻烦，外加到时候做自动部署的时候还需要额外步骤，增加部署失败概率，所以我直接将NexT文件夹里所有的Git信息都删除了。这样做的优点就是可以将其和我们自己的个人网站作为一个整体进行管理，减轻负担，但缺点是到时候NexT升级的时候需要重新下载和覆盖。不过好在NexT才更了一个大版本，所以这个应该暂时不会成为一个问题。

Now we have the following folder structure:
```bash
$ tree -L 1
.
├── _config.yml
├── db.json
├── debug.log
├── next
├── node_modules
├── package.json
├── package-lock.json
├── README.md
├── scaffolds
├── source
└── themes
```

#### 初始配置文件

**修改站点配置文件**
```bash 
$vim ~/GitRepos/Homepages/_config.yml
```
Modify the following items:
**Personal info and them**
```console
# theme: landscape -> theme: next  # delete word in vim: dw 
# Title
# subtitle 
# decription
# author 
# url
```
**Deployement Info**
```console
# Deployment
## Docs: https://hexo.io/docs/deployment.html
deploy:
  type: git
  repo: https://github.com/BinYuOnCa/binyuonca.github.com.git
  branch: master
  message: "Message in Homepage/_config.yml"
```

尝试将网页部署至GitHub Pages服务器端：
```console
# 你的终端此时位置需要在个人主页仓库文件夹中
$ npm install hexo-deployer-git --save
$ npm install
$ hexo g 
$ hexo d
```

创建.gitignore文件，将源码提交至GitHub服务器：
```bash
$ cat .gitignore
.DS_Store
.deploy*/
*.log
public/
db.json
node_modules/
*.swp

# 确认我们现在在pg-source分支
$ git branch
  master
* pg-source
$ git add . 
$ git commit -m 'Configured .... '
$ git push
```
Now check  https://binyuonca.github.io, it will show exactly as the local server at : localhost:4000.


### 个性化和功能插件配置

**配置头像和媒体信息**

TBD ...

**开启标签和分类**
```console
$vim theme/next/_config.yml
# uncomment  tags / categories 

$ hexo new page "tags"
INFO  Created: ~/GitRepos/Homepage/source/tags/index.md
$ hexo new page "categories"
INFO  Created: ~/GitRepos/Homepage/source/categories/index.md
$ 
```

Then modify the two index.md files:
```
~/GitRepos/Homepage/source/tags$ cat index.md
---
title: tags
date: 2020-07-01 17:58:51
type: "tags"
layout: "tags"
comments: false 

~/GitRepos/Homepage/source/categories$ cat index.md 
---
title: categories
date: 2020-07-01 17:59:01
type: "categories"
layout: "categories"
comments: false
---
```


#### 主题配置
TBD



### 使用 Travis CI 自动更新 GitHub Pages

Ref: [使用 Travis CI 自动更新 GitHub Pages](https://notes.iissnan.com/2016/publishing-github-pages-with-travis-ci/)

1 Create Github Personal Access Token 
under Setting/Developer settings/Personal access tokens

create token
choose: repo and admin:repo_hook

Token:
07ee99afebd067c6b418141e7dd7737791f54a83


2 install local travis command line :
``` bash
$ruby -v 
$sudo gem install travis --no-document

```
For Ubuntu, you need to install corresponding -dev before install travis:
``` bash
$ sudo apt-get install ruby-dev
```
Also we need work around for file not found issue [#622](https://github.com/travis-ci/travis.rb/issues/622)

```bash
~/GitRepos/Homepage$ which travis
/usr/local/bin/travis
~/GitRepos/Homepage$ ./usr/local/bin/travis
bash: ./usr/local/bin/travis: No such file or directory
$ sudo ln -s /usr/local/bin/travis /usr/bin/travis
~/GitRepos/Homepage$ ls -al /usr/bin/travis
lrwxrwxrwx 1 root root 21 Jul  1 22:47 /usr/bin/travis -> /usr/local/bin/travis
~/GitRepos/Homepage$ travis version
Shell completion not installed. Would you like to install it now? |y| y
1.9.1
~/GitRepos/Homepage$ travis version
1.9.1
```