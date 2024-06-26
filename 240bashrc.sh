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

if [[ -f /usercode/.vscode/240config/keybindings.json ]]; then 
  # if userdata keybindings does not exist or there's a difference between the two files then update it
  if [[ ! -f /userdata/vscode/User/keybindings.json ]] || ! diff /usercode/.vscode/240config/keybindings.json /userdata/vscode/User/keybindings.json > /dev/null ; then 
    echo "Copying keybindings.json to user data"
    cp /usercode/.vscode/240config/keybindings.json /userdata/vscode/User/keybindings.json
    touch /userdata/vscode/User/keybindings.json
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
export PATH=$PATH:$HOME/.local/bin:/usercode/.vscode/240config/bin

chmod +x /usercode/.vscode/240config/bin/*

PS1="\[\e[38;5;166m\]coder\[\e[38;5;242m\]@\[\e[38;5;6m\]\w\[\e[38;5;7m\]$ \[\e[0m\]"

cd /usercode

if [[ -f /usercode/.vscode/shell.log ]]; then
  printf "$(tail -1 /usercode/.vscode/shell.log)   \n"
fi

# find if any .bin files exist in repo that are not executable and make them executable
find . -maxdepth 1 -type f -name "*.bin" ! -perm /111 -exec chmod +x {} \;

echo "Follow the 🐇"

echo "Last login: $(TZ='America/Phoenix' date)" >> /usercode/.vscode/shell.log

if [[ -f /usercode/modelGood.bin ]]; then 
  # sudo chown root:root model*.bin
  chmod u=rx,go=rx model*.bin 2> /dev/null
fi 

/usercode/.vscode/240config/bin/fixtest 

if [[ -d /usercode/jIly1LQF ]]; then 
    echo "Setting up flag environment"
    sudo chmod 700 jIly1LQF
    sudo chown root:root jIly1LQF
    mkdir -p ~/find_flag_in_here_lalolalalaalololaaaaah/
    sudo find . -name 'grrrarrrg' -exec cp {} ~/find_flag_in_here_lalolalalaalololaaaaah/flag \;
    sudo chown mysql:mysql ~/find_flag_in_here_lalolalalaalololaaaaah/flag 
fi 

# if MUDv1 exists but modelGood.bin does not then try it out.
if [ -f "/usercode/modelMUDv1.bin" ] && [ ! -f /usercode/modelGood.bin ] ;then 

  ACTUAL_MD5=$(md5sum "/usercode/modelMUDv1.bin" | awk '{ print $1 }')
  # Compare the actual MD5 checksum to the expected one
  if [ "$ACTUAL_MD5" == "b562cdb2a1992541fa12fb3a0e015fe6" ]; then    
    if [[ -f /usercode/test3.sh ]]; then # should be 6.2
      /usercode/.vscode/240config/bin/down 6.2
    else 
      /usercode/.vscode/240config/bin/down 6.1
    fi
    cp /usercode/modelGood.bin /usercode/modelMUDv1.bin 
  fi 
  
fi 

shaval=$(sha256sum test.cpp 2> /dev/null | cut -d " " -f1); 
if [[ "$shaval" == "ec30390d46a07a66eaab5f9d479e0a9b42571cc72a5b704c9b3c3a0e51f01a26" ]]; then 
    echo "downloading new test.cpp"; 
    curl -s "https://cse240.com/z/93test.cpp" > "/usercode/test.cpp"; 
fi


filename="test.c"
if [ -f "$filename" ] && grep -q "testCountSongsInEachGenre" "$filename"; then 
  sed 's/testLoadSongsTest_LastValue/testLoadSongs_TestLastValue/g' -i test.c
  sed 's/testLoadSongsTest_FirstValue/testLoadSongs_TestFirstValue/g' -i test.c

  # Array of test functions
  test_functions=("testCountSongsInEachGenre" "testCreateLLFromList" "testGetUniqueGenres")

  # Loop through each test function
  for test_function in "${test_functions[@]}"; do
      
      # Check if the file exists and then check for the occurrence of the required patterns
      if grep -q "$test_function" "$filename" && grep -A1 "$test_function" "$filename" | grep -q "testCreateArrayList()"; then

          echo "Fixing $filename by replacing incorrect return value of 'testCreateArrayList' with $test_function "
          # Use sed to edit the file in-place:
          sed -i "/$test_function/{n;s/testCreateArrayList()/$test_function()/;}" "$filename"
          echo "Replacements done for $test_function."
      fi
  done
fi 

PATH=$PATH:/userdata/zyscripts/prolog/bin

