#!/usr/bin bash

gcc -Wall -Werror main.c -o ./modelGood.bin 

strip --strip-all ./modelGood.bin 

for x in $(grep -E "BROKEN_VERSION_[0-9]" main.c | grep -Eoh "[0-9]+"); do 
    gcc -D BROKEN_VERSION_${x} -Wall -Werror main.c -o ./modelBad${x}.bin 
    strip --strip-all ./modelBad${x}.bin 
done