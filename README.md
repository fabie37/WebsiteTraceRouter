# Network Trace Router usage.

Overview usage for this project.

## Dependancies
- Needs graphviz library: Ubuntu install *sudo apt install graphviz*
- Needs clang compiler
- Needs python Version>=3.8

## Running the program
- To clean: *make clean*
- To run dns lookup: *make lookup*
- To change websites to lookup: edit websites file
- To run the trace routes for websites: *make traceroute*
- To process returned routes: *make processroutes*


## Normal Usage
1. **$ make traceroute**
2. **$ make processroutes**