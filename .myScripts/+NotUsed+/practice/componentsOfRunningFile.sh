#!/bin/sh
################################################
# Скрипт для выделения из полного пути к файлу:
# - пути к файлу
# - имени файла с расширением
# - последнего расширения файла
################################################

echo $0
tmpVar=$0
dir="${tmpVar%/*}"
fname="${tmpVar##*/}"
ext="${tmpVar##*.}"
echo "tmpVar=$tmpVar"
echo "dir=$dir"
echo "fname=$fname"
echo "extention=$ext"

var="Hello"
echo $var
echo ${var} world!

exit 0
