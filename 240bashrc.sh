#! /usr/bin/env bash

if [[ ! -f /usercode/.vscode/settings.json ]]; then 
  cp /usercode/.vscode/240config/settings.json /usercode/.vscode/settings.json
fi 

if [[ ! -f /usercode/.vscode/launch.json ]]; then 
  echo "Copying launch.json"
  cp /usercode/.vscode/240config/launch.json /usercode/.vscode/launch.json
fi 

if [[ ! -f /usercode/.vscode/tasks.json ]]; then 
  if [[ -f /usercode/Makefile ]]; then 
    cp /usercode/.vscode/240config/make/* /usercode/.vscode
  elif ls /usercode/*.cpp 1> /dev/null 2>&1; then
    cp /usercode/.vscode/240config/c++/* /usercode/.vscode
  elif ls /usercode/*.c 1> /dev/null 2>&1; then
    cp /usercode/.vscode/240config/c/* /usercode/.vscode
  fi   
fi 

question_file=$(ls /usercode/??-??*questions.json 2> /dev/null)
ret=$?
if [[ $ret -eq 0 ]]; then
  if grep "correct_answer" ${question_file}; then
    printf "\033[38;5;1mERROR: wrong file left for questions, contact the professor, immediately.\n"
    rm -f $question_file
  fi
  if [[ ! -d ~/.local/lib/python3.8/site-packages/pygments ]]; then
    echo "Setting up for questions..."
    curl -s -L "https://raw.githubusercontent.com/etrickel/cse240data/main/local.tar.gz" | tar -xz -C $HOME
  fi
  chmod +x /usercode/.vscode/answer-questions
  PATH=$PATH:/usercode/.vscode
  export PYTHONPATH=$HOME/.local/lib/python3.8/site-packages
  printf "\033[38;5;226mThis is a questions lab, where you will answer multiple choice questions\n \033[0m"
  printf "run the program 'answer-questions' or hit the up arrow and hit enter\n"
  echo "answer-questions" > /usercode/.vscode/bash_history
else
  export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
  alias gmm='gcc /usercode/main.c -Wall -Werror -g -o /usercode/main.bin'
  alias r='/usercode/a.out'
fi

export HISTFILE="/usercode/.vscode/bash_history"
export PATH=$PATH:$HOME/.local/bin
PS1="\[\e[38;5;166m\]coder\[\e[38;5;242m\]@\[\e[38;5;6m\]\w\[\e[38;5;7m\]$ \[\e[0m\]"

cd /usercode

if [[ -f /usercode/.vscode/shell.log ]]; then
  printf "$(tail -1 /usercode/.vscode/shell.log)   \n"
fi

# find if any .bin files exist in repo that are not executable and make them executable
find . -maxdepth 1 -type f -name "*.bin" ! -perm /111 -exec chmod +x {} \;

echo "Follow the 🐇"

echo "Last login: $(TZ='America/Phoenix' date)" >> /usercode/.vscode/shell.log

