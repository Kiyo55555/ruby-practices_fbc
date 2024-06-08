#!/bin/sh

tests=("6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5" "6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X" "0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4" "6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0" "6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,1,8" "X,X,X,X,X,X,X,X,X,X,X,X" " X,X,X,X,X,X,X,X,X,X,X,2" "X,0,0,X,0,0,X,0,0,X,0,0,X,0,0")

for test in ${tests[@]}; do
    echo "bowling.rb" $test
    ruby bowling.rb $test
done
