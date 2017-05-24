CC=gcc
DC=dmd # or ldc2 or gcd (ldc2 is faster)

all: binary

libexported.so: exported.d
	$(DC) -c -fPIC exported.d
	$(DC) -oflibexported.so exported.o -shared -defaultlib=libphobos2.so -L-rpath=/usr/lib/x86_64-linux-gnu

binary: useexported.c useexported.h libexported.so
	$(CC) useexported.c useexported.h -L. -lexported -o binary

clean: 
	rm libexported.so binary
