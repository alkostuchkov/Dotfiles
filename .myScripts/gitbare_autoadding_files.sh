#!/usr/bin/env bash

# Automate adding files to git

config="/usr/bin/git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME"

echo "Choose what to add:"
echo "1) Deleted files."
echo "2) Modified files."
echo "3) All files."

read choice

case ${choice} in
  1) what_to_add="deleted:";;
  2) what_to_add="modified:";;
  3) what_to_add="deleted:|modified:";;
  *) echo -e "Wrong choice.\nExit."; exit 1;;
esac

echo "Go to the $HOME (WHERE THE BARE GIT IS)..."
cd ~ &>/dev/null

for path in $(${config} st | grep -E "${what_to_add}" | awk '{print $2}')
do
  ${config} add -f ${path}
  # ${config} add -f ${path} 2>/dev/null
  # echo $path
done

# Back to the previous dir
echo "Back to the $OLDPWD (PREVIOUS DIR)..."
cd - &>/dev/null

