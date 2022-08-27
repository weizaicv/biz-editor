#!/bin/bash

#切换到master分支 main分支
git checkout main

#获取最新的master分支代码
git pull origin main

# npm version xxx最后的类型 patch minjor minor三选一
version_type="patch" ## 默认为patch

#执行命令传入参数 （参数数量>=1） 如 `sh ./build/up-version.sh patch`
if [ $# -eq 1 -o $# -gt 1 ]
then
	## 参数值必须 patch minor major 三选一
	if [ $1 != "patch" -a $1 != "minor" -a $1 != "major" ]
	then
		echo "参数错误，必须为 patch|minor|major三选一"
		exit 1
	fi
	version_type=$1

	## 对major和minor进行再次确认
	if [ $version_type = 'minor' -o $version_type = 'major' ]
	then 
		read -r -p "你确定执行 npm version $version_type ? [Y/N] " input
		case $input in
			[yY][eE][sS][yY])
				echo "确认，继续执行"
				;;
			[nN][oO][nN])
				echo "取消执行"
				exit 1
				;;
			*)
				echo "非法输出，取消执行"
				exit 1
				;;
		esac
	fi
fi

echo "version_type: $version_type"

#升级npm 版本并且自动生成git tag
npm version $version_type

# push tags , 触发github actions
git push origin --tags