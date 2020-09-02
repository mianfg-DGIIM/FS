# EXAMEN 2 BASH - FUNDAMENTOS DEL SOFTWARE 1º DGIIM GRUPO 1
# Alumno: Miguel Ángel Fernández Gutiérrez, 20070335Y
# Ejercicio 2

examen2: pr.o complex.o geom.o vector.o
	g++ -g -I./ -L./ -o examen2 pr.o complex.o geom.o vector.o

pr.o: pr.cpp
	g++ -g -I./ -c pr.cpp

complex.o: complex.cpp
	g++ -g -I./ -c complex.cpp

geom.o: geom.cpp
	g++ -g -I./ -c geom.cpp

vector.o: vector.cpp
	g++ -g -I./ -c vector.cpp

limpiar:
	rm pr.o complex.o geom.o vector.o examen2

instalar: examen2
	mkdir ./bin
	mkdir ./Fuentes
	cp examen2 ./bin
	cp *.cpp *.h ./Fuentes
	rm examen2 pr* complex* geom* vector*

desinstalar:
	cp ./Fuentes/* ./
	rm -rf bin
	rm -rf Fuentes
