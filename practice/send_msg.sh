#!/bin/bash
# 查看用户是否登录
user=$1
login_user=$(who | awk '$1 ~ /^'$user'$/{print $1}')  # 对第一列用户名与输入的用户名进行匹配
if [ -z $login_user ]  # 如果没有该用户就退出
then
	echo "用户\"$1\"不在线"
	exit
fi
# 查看用户是否开启消息功能
is_allowed=$(who -T | awk '$1 ~ /^'$user'$/{print $2}')  # 判断第二列是加号还是减号
if [ $is_allowed != '+' ]  # 如果用户没开启就退出
then
	echo "用户\"$1\"未开启消息功能"
	exit
fi
# 判断要发送的消息是否为空
if [ -z $2 ]
then
	echo "发送的消息不能为空"
	exit
fi
# 从参数中获取要发送的信息
msg=$(echo $* | cut -d " " -f 2-)
# 用户登录的终端
terminal=$(who | awk '$1 ~ /^'$user'$/{print $2}')
# 发送消息
echo $msg | write $user $terminal
# 异常情况处理
if [ $? != 0 ]
then
	echo "发送失败"
else
	echo "发送成功"
fi
