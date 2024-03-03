#!/usr/bin bash

if [[ -z "$1" ]]; then
    checkfile="main.c"
else
    checkfile=$1
fi 

make clean
make 
cp ./main.bin ./modelGood.bin

strip --strip-all ./modelGood.bin 

for x in $(grep -E "BROKEN_VERSION_[0-9]" $checkfile | grep -Eoh "[0-9]+" |sort -u ); do 
    CFLAGS=-DBROKEN_VERSION_${x} make 
    cp ./main.bin ./modelBad${x}.bin 
    strip --strip-all ./modelBad${x}.bin 
done