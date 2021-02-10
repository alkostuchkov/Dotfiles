#!/bin/bash

while :
   do
      python /home/$USER/conky/ymail.py > /home/$USER/conky/ymailOutput.txt
      #echo "ymail "
      #cat /home/$USER/conky/ymailOutput.txt
      python /home/$USER/conky/gmail.py > /home/$USER/conky/gmailOutput.txt
      #echo "gmail "
      #cat /home/$USER/conky/gmailOutput.txt
      sleep 300
   done

