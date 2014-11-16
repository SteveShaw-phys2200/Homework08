GRAPH = gnuplot
CC = gcc
CFLAGS = -Wall -O0 -g -std=c99
LFLAGS = -O0 -g
LIBS = -lgsl -lgslcblas -lm 
COMPILATION = ${CC} $(LFLAGS) -o $@ $^ $(LIBS)
RESCODE = ./$^ > $@
PNGCODE = $(GRAPH) $@.gpl

all: glider-velocity.png glider-angle.png glider-height.png

glider_height: glider_height.o 
	$(COMPILATION)
glider_velocity: glider_velocity.o
	$(COMPILATION)
glider_angle: glider_angle.o
	$(COMPILATION)

res-height: glider_height
	$(RESCODE)
res-velocity: glider_velocity
	$(RESCODE)
res-angle: glider_angle
	$(RESCODE)

glider-velocity.png: glider-velocity.png.gpl res-velocity
	$(PNGCODE)
glider-angle.png: glider-angle.png.gpl res-angle
	$(PNGCODE)
glider-height.png: glider-height.png.gpl res-height
	$(PNGCODE)

clean : 
	rm -f *~
	rm -f *.o
	rm -f glider_velocity glider_angle glider_height

veryclean : clean
	rm -f res-velocity res-height res-angle glider-height.png glider-velocity.png glider-angle.png

