#!/bin/bash

while :
do
   {
      # isConnect=`wget -O - -q icanhazip.com`
      # isConnect=`curl -s ipinfo.io/ip`
      isConnect=`wget -O - -q ipinfo.io/ip`
      if [ -z $isConnect ] #если нет интернета
         then
            echo "No Connection" > /home/inetStatus.txt
            echo "No Connection"
         else #если есть интернет
            echo $isConnect > /home/inetStatus.txt
            echo $isConnect
      fi
      #cat ~/conky/inetStatus.txt
      sleep 5
   }
done
