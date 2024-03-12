
source ~/.bashrc

date >> /tmp/pullinfo.log

if [[ -d /usercode/.vscode/240config ]]; then
  if [[ -d /tmp/240config ]]; then
    rm -rf /tmp/240config 
  fi 
  mv /usercode/.vscode/240config /tmp
  cd /usercode/.vscode 
  git clone https://github.com/etrickel/240config.git  --depth 1 >> /tmp/pullinfo.log 2>&1
  gitret=$?
  if (( gitret == 0 )); then 
    echo "cloned 240config repo" >> /tmp/pullinfo.log
    rm -rf /usercode/.vscode/240config/.git 
  else
    mv /usercode/.vscode/240config /tmp
  fi 
else
  cd /usercode/.vscode 
  git clone https://github.com/etrickel/240config.git  --depth 1 >> /tmp/pullinfo.log 2>&1
fi 

if (( gitret == 0 )); then 
  mbGitSourceFile="/usercode/.vscode/240config/mybashrc.sh"
  if [ -f "$mbGitSourceFile" ]; then
      if ! cmp -s "$mbGitSourceFile" "/usercode/.vscode/mybashrc.sh"; then
        echo "upgrading /usercode/.vscode/mybashrc.sh"
        cp $mbGitSourceFile /usercode/.vscode/mybashrc.sh
      fi
  else
      echo "Unexpected error: $mbGitSourceFile File does not exist."
  fi
else
  echo "Unable to clone 240config repo, contact course staff"
fi 

cd /usercode/.vscode 

source /usercode/.vscode/240config/240bashrc.sh 


