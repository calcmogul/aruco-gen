CPPFLAGS := -O2 -Wall -Wextra -std=c++17

# Specify include paths with -I directives here
IFLAGS := -I/usr/include/opencv4

# Specify libs with -l directives here
LDFLAGS := -lopencv_aruco -lopencv_imgcodecs -lopencv_core -lfmt

rwildcard=$(wildcard $1$2) $(foreach dir,$(wildcard $1*),$(call rwildcard,$(dir)/,$2))

SRC_CPP := $(call rwildcard,src/,*.cpp)
CPP_OBJ := $(SRC_CPP:.cpp=.o)
CPP_OBJ := $(addprefix build/,$(CPP_OBJ))

.PHONY: all
all: build/aruco-gen

-include $(CPP_OBJ:.o=.d)

build/aruco-gen: $(CPP_OBJ)
	@mkdir -p $(@D)
	g++ $+ $(LDFLAGS) -o $@
	@mkdir -p build/markers
	cd build && ./aruco-gen && tar -cf markers.tar.gz markers

build/%.o: %.cpp
	@mkdir -p $(@D)
	g++ $(CPPFLAGS) $(IFLAGS) -MMD -c -o $@ $<

.PHONY: clean
clean:
	-$(RM) -r build/src
	-$(RM) build/aruco-gen
