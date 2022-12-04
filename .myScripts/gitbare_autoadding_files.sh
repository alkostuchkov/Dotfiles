#!/usr/bin/env bash

# Automate adding files to git

config="/usr/bin/git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME"
target_dir=$HOME
E_WRONG_DIR=73
E_WRONG_CHOICE=74

echo "Choose what to add:"
echo "1) Deleted files."
echo "2) Modified files."
echo "3) All files."

read choice

case ${choice} in
  1) what_to_add="deleted:";;
  2) what_to_add="modified:";;
  3) what_to_add="deleted:|modified:";;
  *) echo -e "Wrong choice.\nExit."; exit $E_WRONG_CHOICE;;
esac

echo "Go to the $target_dir (WHERE THE BARE GIT IS)..."
cd $target_dir &>/dev/null

if [[ "$PWD" != "$target_dir" ]]
then
  echo "Wrong dir!"
  echo "Variable $PWD links to another dir!"
  exit $E_WRONG_DIR
fi

for path in $(${config} status | grep -E "${what_to_add}" | awk '{print $2}')
do
  ${config} add -f ${path}
  # ${config} add -f ${path} 2>/dev/null
  # echo $path
done

echo "Back to the $OLDPWD (PREVIOUS DIR)..."
cd - &>/dev/null

