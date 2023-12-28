#! /usr/bin/env bash


rm -rf /usercode/.vscode 
mkdir /usercode/.vscode 
cd /usercode/.vscode 

git clone https://github.com/etrickel/240config.git 

cp 240config/mybashrc.sh . 
cp 240config/settings.json . 

bash --rcfile /usercode/.vscode/mybashrc.sh

