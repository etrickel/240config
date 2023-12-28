source ~/.bashrc

if [[ ! -d /usercode/.vscode/240config ]]; then
  cd /usercode/.vscode
  git clone https://github.com/etrickel/240config.git  
else  
  cd /usercode/.vscode/240config
  date >> /tmp/pullinfo.log
  git pull >> /tmp/pullinfo.log
  cd ..
fi 

cd /usercode/.vscode 

source /usercode/.vscode/240config/240bashrc.sh 


