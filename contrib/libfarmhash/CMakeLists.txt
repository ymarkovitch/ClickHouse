include_directories (${CMAKE_CURRENT_BINARY_DIR})

add_library(farmhash STATIC
	farmhash.cc
	farmhash.h)
