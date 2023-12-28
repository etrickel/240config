source ~/.bashrc

date >> /tmp/pullinfo.log

if [[ ! -d /usercode/.vscode/240config ]]; then
  cd /usercode/.vscode
  git clone https://github.com/etrickel/240config.git  >> /tmp/pullinfo.log 2>&1
else  
  cd /usercode/.vscode/240config
  git pull >> /tmp/pullinfo.log 2>&1
  cd ..
fi 

cd /usercode/.vscode 

source /usercode/.vscode/240config/240bashrc.sh 


