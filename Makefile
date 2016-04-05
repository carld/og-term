
PLATFORM = $(shell uname)
REV = $(shell git rev-parse HEAD)

ifeq ($(findstring Linux,$(PLATFORM)),Linux)
  $(info Building revision $(REV) for $(PLATFORM))
else
  $(error $(PLATFORM) is not supported)
  $(shell exit 2)
endif

GIT = /usr/bin/git

CC = gcc

CFLAGS += -g -Wall -O2  -D_GNU_SOURCE
CFLAGS += -I./libtsm/src -I./libtsm -I./libshl/src
LFLAGS += -lglfw -lGLU -lGL -lGLEW -lm  -lxkbcommon -lX11

TSM = $(wildcard libtsm/src/*.c) $(wildcard libtsm/external/*.c)
SHL = libshl/src/shl_pty.c

SRC = $(SHL) $(TSM)
SRC += main.c display.c font/bdf.c terminal.c 
SRC += shader.c
OBJ = $(SRC:.c=.o)
BIN = og-term

.PHONY: clean

.c.o:  $(SRC)
	$(CC) -c $(CFLAGS) $< -o $@

$(BIN): $(OBJ) 
	$(CC) -o $@ $(OBJ)  $(LFLAGS)

clean:
	rm -vf $(BIN) $(OBJ)


