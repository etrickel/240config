source ~/.bashrc

date >> /tmp/pullinfo.log

if [[ -d /usercode/.vscode/240config ]]; then
 
  if [[ -d /usercode/.vscode/240config/.git ]]; then
    cd /usercode/.vscode/240config
    echo "Pulling updates" >> /tmp/pullinfo.log
    git pull >> /tmp/pullinfo.log 2>&1
    gitret=$?    
    cd ..
  else 
    rm -rf /usercode/.vscode/240config
    cd /usercode/.vscode
    git clone https://github.com/etrickel/240config.git  >> /tmp/pullinfo.log 2>&1
    gitret=$?
  fi
  if [[ ! -f /usercode/.vscode/240config/240bashrc.sh ]]; then
    cd /usercode/.vscode/240config
    echo "Reseting git repo"
    git reset --hard HEAD >> /tmp/pullinfo.log 2>&1
    gitret=$?
    cd ..
  fi  
else  # if 240config does not exist then clone
  cd /usercode/.vscode
  echo "240config does not exist cloning repo" >> /tmp/pullinfo.log
  git clone https://github.com/etrickel/240config.git  >> /tmp/pullinfo.log 2>&1
  gitret=$?
fi 
if (( gitret != 0 )); then # if active above fails attempt to re-clone 240config repo
  rm -rf /usercode/.vscode/240config
  cd /usercode/.vscode
  git clone https://github.com/etrickel/240config.git  >> /tmp/pullinfo.log 2>&1
  gitret=$?
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


