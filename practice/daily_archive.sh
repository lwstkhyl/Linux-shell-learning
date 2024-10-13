#!/bin/bash
if [ $# -ne 1 ]  # 如果参数个数不为1
then
	echo "参数个数错误，应输入一个参数作为归档目录名"
	exit  # 退出脚本
fi
if [ -d $1 ]  # 如果是一个目录，就继续执行
then
	[  ]
else  # 如果不是就退出
	echo "目录不存在"
	exit
fi
dir_name=$(basename $1)  # 目录名称
dir_path=$(cd $(dirname $1); pwd)  # 目录所在文件夹的绝对路径
dir_entire_path=${dir_path}/${dir_name}  # 目录的完整绝对路径
date=$(date +%y%m%d)  # 日期
file_name=archive_${dir_name}_${date}.tar.gz  # 生成的归档文件名称
des_path=/home/lwstkhyl/桌面/shell-learning/archive  # 归档文件的存放位置
entire_path=${des_path}/${file_name}  # 生成的归档文件的完整绝对路径
echo "开始归档，归档文件夹路径为$dir_entire_path"
echo 
cd $dir_path
tar -czf $entire_path $dir_name
if [ $? -eq 0 ]
then
	echo "归档成功，归档文件路径为$entire_path"
else
	echo "归档失败"
fi
exit
