#!/bin/bash

# IMPORTANT NOTE:
# Current working directory must not have whitespaces in its name

# Usage Examples:
# ./miniTest.sh exec.cpp testCases
# ./miniTest.sh exec.cpp RandomDirectory1/RandomDirectory2/testCases

# Get the current path as a variable to come back later
execPath="`pwd`"

# Set a name for the compiled executable (remove .cpp)
# Usage Example: 
# Filename = exec.cpp, when executed will be ./exec
execName="`ls | grep $1 | sed 's/.cpp//'`"

# Compile the given C/C++ filename (stored in argument 1)
# YOU MAY EDIT THIS LINE OF CODE WHEN NEEDED
g++ -pedantic-errors -std=c++11 $1 -o $execName

# Go to the test case file (stored in argument 2)
cd $2

# Store all the input filenames into arrays
testInput=($(ls | grep .in))

# Store all the input filenames into arrays
testOutput=($(ls | grep .out))

# Go back to execution path
cd $execPath

# Create a function to be executed when an error happens
function exitHandle () {

    # Gets the error message
    if [ $? -gt 0 ]
    then
        echo -e "${BIRed}See Error Message Above"
        echo -e "Test Case Failed Execution: ${testOutput[$i]}${NC}"
    fi

    # Remove comparison file
    rm output.txt
    exit 1
}

# Some colors for the the test pass/fail text
BIRed='\033[4;91m'      # Bold High Intensity Red
BIGreen='\033[1;92m'    # Bold High Intensity Green
BIOrange='\033[1;94m'   # Bold High Intensity Orange
NC='\033[0m'            # No color

# Stop the process if there is any error
# We need to do this if there is large input with thousands of lines
# Errors such as segmentation faults can occur mid way during input

set -e
trap "exitHandle" EXIT

# Run all test cases, each under trap
for ((i=0; i < ${#testInput[@]}; i++)); do
    touch output.txt

    # Use each input file in the array
   ./$execName < "$2/${testInput[$i]}" > output.txt

    # Compare true output with desired output
    DIFF=$(diff -w output.txt $2/${testOutput[$i]}) 

    # If there is no difference then we pass the test
    # If there are differences then we show them on screen
    if [ "$DIFF" == "" ] 
    then 
        echo -e "${BIGreen}Test Case Passed: ${testOutput[$i]}${NC}"
    else 
        echo -e "${BIOrange}Test Case Failed.${NC}"
        echo "Corrections for ${testOutput[$i]} :"
        eval "$DIFF"
    fi

done