#!/bin/bash
####################################
# Script for exchange 
# /bin/bash to /bin/sh or
# /bin/sh to /bin/bash
# in all files (except this file)
# in the current directory.
####################################

exchange()
{
#   cd "$fileDir"
   for filename in *
   do
      if [ -f "$filename" ] && [ "$filename" != "$runFileName" ]
      then
         echo $filename
         sed "s/"$var1"/"$var2"/g" $filename > filenameNew
         mv filenameNew "$filename"
         chmod +x $filename
      fi
   done
#   cd "$preDir"
}

while :
do
   # Отделяем имя запускаемого скрипта,
   # чтобы исключить его из замены
   # (если он находится в обрабатываемой директории
   runFileName="${0##*/}"
   # как вариант:
   # runFileName=`basename $0`
   echo "You have just run the file: "$runFileName""
   echo

   # Проверяем директорию, в которой лежат
   # файлы для обработки
   # (по умолчанию - текушая директория)
##   filesDir=$1
   # Запоминаем текущую директории,
   # чтобы потом вернутся
##   preDir=$(pwd)
#   if [[ "$filesDir" == "" ]]
#   then
#      filesDir=$(pwd)
#      filesDir="${filesDir}"
#   else
#      filesDir="${filesDir}"
#   fi
#   echo $filesDir

   echo "Choose the number."
   echo "1. Exchange /bin/bash to /bin/sh"
   echo "2. Exchange /bin/sh to /bin/bash"
   echo "3. Exit without chaingings."

   read num
   case $num in
      1) var1="\/bin\/bash"
         var2="\/bin\/sh"
         exchange
         exit 0
         ;;
      2) var1="\/bin\/sh"
         var2="\/bin\/bash"
         exchange
         exit 0
         ;;
      3) exit 0 ;;
      *) echo "Choose the number: 1, 2 or 3." ;;
      esac
done

exit 0
