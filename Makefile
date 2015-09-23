######################################################################
# C Makefile
# 
# Usage:
#  `make run`: Builds and runs the project
#  `make clean`: Cleans object files created on build
#  `make gprof`: Runs the program using gprof (tool for profiling)
#  `make valgrind`: Runs the program using valgrind (tool to help detect memory leaks)
# 
# 
# Author:
# Bruno Peres - https://github.com/brunomperes
# Distributed under MIT license
######################################################################

# Required object list (list all your .c files, but replace the file extension to .o)
OBJS = main.o io.o heuristic.o

# Runnable name
MAIN = my-project

# Parameters to call the runnable
ARGS = -i input.txt -o output.txt

# Valgrind options
VALOPS = --leak-check=full --show-reachable=yes

# Specifies the compiler (defaults are: gcc for C projects, gpp for C++ projects)
CC = gcc

# Specifies compiler options
# -Wall enables compiler warnings
# -pg enables gprof for code profiling
# -g3 enables debugging information
CFLAGS = -Wall -pg -g3

# Bash command to clean without confirmation
RM = rm -f

# Buils the program and links dependencies
$(MAIN): $(OBJS)
	@echo ""
	@echo " --- COMPILANDO PROGRAMA ---"
	@$(CC) $(CFLAGS) $(OBJS) -lm -o $(MAIN)
	@echo ""

%.o: %.c %.h
	@echo ""
	@echo " --- COMPILANDO OBJETO \"$@\""
	@$(CC) $(CFLAGS) $< -c 

clean:
	$(RM) $(MAIN) *.o
	$(RM) gmon.out

run: $(MAIN)
	./$(MAIN) $(ARGS)
	
valgrind: $(MAIN)
	valgrind $(VALOPS) ./$(MAIN) $(ARGS)

gprof: $(MAIN)
	./$(MAIN) $(ARGS)
	gprof -b -p $(MAIN)

