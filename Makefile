CC= gcc
CFLAGS= -I/usr/include/SDL/ -Wall -g
LFLAGS= -I/usr/include/SDL/ -lSDLmain -lSDL -lSDL_image -lSDL_ttf -lSDL_mixer

default: beret

clean:
	rm -f beret *.o
	rm -Rf debian/beret

installman: beret.6
	mkdir -p ${DESTDIR}/usr/share/man/man6/
	install -o root -g root -m 0644 beret.6 ${DESTDIR}/usr/share/man/man6/beret.6

install: installman
	mkdir -p ${DESTDIR}/usr/games
	mkdir -p ${DESTDIR}/usr/share/beret/images
	mkdir -p ${DESTDIR}/usr/share/beret/music
	mkdir -p ${DESTDIR}/usr/share/beret/sfx
	mkdir -p ${DESTDIR}/usr/share/beret/rooms

	install -m 0640  -t ${DESTDIR}/usr/share/beret/images ./images/*
	install -m 0640  -t ${DESTDIR}/usr/share/beret/music ./music/* 
	install -m 0640  -t ${DESTDIR}/usr/share/beret/sfx ./sfx/* 
	install -m 0640  -t ${DESTDIR}/usr/share/beret/rooms ./rooms/*
	install -m 0640  -t ${DESTDIR}/usr/share/beret ./AveriaSans-Regular.ttf
	install ./beret ${DESTDIR}/usr/games

beret: game.o thing.o physics.o
	$(CC) $(LFLAGS) -o $@ game.o thing.o physics.o

%.o: %.c %.h
