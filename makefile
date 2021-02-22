.PHONY : njoy platform
CFLAGS=-g -Wall -Isource/include -std=c++17
GLFWSRC := \
source/include/glad/glad.c 
ifeq ($(OS),Windows_NT)
GLFWSRC+=build/win32/glfw3.dll
GLFWSRC+=build/win32/lua53.dll
endif

ENGINESRC:= \
source/engine/luabinding/*.cpp
INCLUDESRC=$(GLFWSRC)  $(ENGINESRC)

CC=g++
ifeq ($(OS),Windows_NT)
platform:TARGET:=build/win32/njoy.exe
else
ifeq ($(shell uname),Darwin)
platform:TARGET:=build/macOS/njoy.out
endif
endif

platform:SRC += source/engine/main.cpp
ifeq ($(OS),Windows_NT)
platform:LDFLAGS+= -lgdi32 -lopengl32
else
ifeq ($(shell uname),Darwin)
platform:LDFLAGS+= -lglfw -llua -lfreetype
endif
endif
platform:$(SRC) njoy
njoy:
	$(CC) $(CFLAGS) -o $(TARGET) $(SRC) $(INCLUDESRC) $(LDFLAGS)
.PHONY: clean
clean:
	rm ./build/macOS/njoy.out
	rm ./build/macOS/njoy.exe