LIB     = imgui_piglet
CPPFILES   := $(foreach dir,., $(wildcard $(dir)/*.cpp))
OBJS     := $(CPPFILES:.cpp=.o)
PREFIX ?= $(DOLCESDK)/arm-dolce-eabi
CC      = arm-dolce-eabi-gcc
CXX 	= arm-dolce-eabi-g++
AR      = arm-dolce-eabi-ar
CFLAGS += -Wl,-q -Wall -O2 -DGLFW_INCLUDE_ES2=1 -DIMGUI_IMPL_OPENGL_ES2=1
CXXFLAGS  = $(CFLAGS) -fno-exceptions -std=gnu++11
ASFLAGS = $(CFLAGS)

all: lib$(LIB).a

%.a: $(OBJS) 
	$(AR) -rc $@ $^

clean:
	@rm -rf $(OBJS) lib$(LIB).a

install: lib$(LIB).a
	@mkdir -p $(DESTDIR)$(PREFIX)/include/$(LIB)
	@cp *.h $(DESTDIR)$(PREFIX)/include/$(LIB)
	@mkdir -p $(DESTDIR)$(PREFIX)/lib/
	@cp lib$(LIB).a $(DESTDIR)$(PREFIX)/lib/

.PHONY: install clean
