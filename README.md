# MiniTest
Automated C/C++ testing and compiling for daily assignments with Bash. Useful for small-scale tasks, scripts, and daily workflows.

## How It Works
It's a rather simple script. Firstly, it scrapes the test folder for `.in` and `.out` files. It stores the name of these files in two arrays, one for input and the other for output. Then we use a loop to go through every single entry, and direct the input file name as standard input to the compiled executable. Standard output is redirected to a temporary file called `output.txt`. Afterwards, the script uses `diff` to compare `output.txt` with the corresponding `.out` content. It will print pass or fail based on the results of `diff`. 

The script also uses `trap` so that the loop is exited any time there is an error. It prints the error message and terminates the process. This is especially helpful when we have a large number of lines from the `.in` files.

There are some usage examples in the commented lines of the code. There are also extra instructions for compiling and switching between C and C++. Users are encouraged to read the documentation.

## Important Notes
There are three conditions that will harm the execution of `MiniTest`. The code will not execute properly if any of these are violated.
- This script assumes that the number of `.in` and `.out` files are equal.
- This script requires that the execution path, that is, the name of the working directory, which by default is MiniTest to not have whitespaces.
- When inputting the relative path as the second argument of `MiniTest` do not put `/` at the start of the path.

## Execution Instructions:
1. Make sure you have Git installed on your device.
1. Open your terminal, choose your desired directory and clone the repository by executing `git clone https://github.com/theo-obadiah-teguh/MiniTest.git`.
1. Enter your GitHub username and token (if applicable).
1. Put your desired C/C++ script and all its dependencies in the cloned directory `MiniTest`.
1. Move your folder comprising of `.in` and `.out` files into the cloned directory `MiniTest`.
1. Enter the cloned directory with `cd` and provide execution access by running `chmod +x miniTest.sh` in the command line.
1. Run MiniTest by entering `./miniTest.sh [C_OR_CPP_FILENAME] [TEST_FOLDER_RELATIVE_PATH]` in the command line.

## Remarks
This script has never been formally tested. Feel free to try it out and provide feedback on it.
