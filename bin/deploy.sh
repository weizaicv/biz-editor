#!/bin/bash

# 执行时传入两个参数：参数1-github密码 参数2-tag
# 如 `sh bin/deploy.sh xxx v1.0.1`
# 通过$1 $2 依次获取参数

teamPath="/home/work/lego-team" #team目录
repoPath="/home/work/lego-team/biz-editor" #项目目录 要和repo同名
repoGitUrl="https://github.com/weizaicv/biz-editor.git" #或者是https://username:$1@github.com/imooc-lego/biz-editor.git

if [ ! -d "$teamPath" ]; then
	#不存在tream目录，则创建
	echo ================ mkdir "$teamPath" ================
	mkdir "$teamPath"
fi
cd "$teamPath"

if [ ! -d "$repoPath" ]; then
	#不存在repo目录，则git clone (私有项目，需要github 用户名和密码)
	echo ================ git clone start 1 ================
	git clone "$repoGitUrl"
	git remote remove origin; #删除origin，否则会暴露github密码
	echo ================ git clone end 2 ================
fi
cd "$repoPath"
git checkout . #撤销一切文件修改 否则会pull失败
git remote add origin "$repoGitUrl"
git pull origin main # 重新下载最新mater代码 tag是基于master分支提交
git fetch --tags #获取所有tags，否则光执行git pull origin master获取不到提交的分支
git remote remove origin; # 删除 origin ，否则会暴露 github 密码

#切换到 tag 重要！
git checkout "$2"
echo ================ git checkout "$2" ================

#安装依赖
npm install --registry https://registry.npm.taobao.org

## 运行 重启 服务
npm run prd

echo ================ deploy success ================


