INSTALL_DIR=./programa

all: programa.out

programa.out: pr.o ./libmates.a
	g++ -g -I./ -L./ pr.o -lmates -o programa.out

pr.o: pr.cpp
	g++ -g -I./ -c pr.cpp

libmates.a: geom.o complex.o vector.o
	ar -rvs libmates.a geom.o complex.o vector.o

geom.o: geom.cpp
	g++ -g -I./ -c geom.cpp

complex.o: complex.cpp
	g++ -g -I./ -c complex.cpp

vector.o: vector.cpp
	g++ -g -I./ -c vector.cpp

install:
	cp programa.out $(INSTALL_DIR)

uninstall:
	rm $(INSTALL_DIR)/programa.out

clear:
	rm pr.o libmates.a geom.o complex.o vector.o

debug:
	gdb -x ./guion.gdb programa.out
