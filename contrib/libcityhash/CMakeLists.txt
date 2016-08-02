include_directories (include src)

add_library(cityhash STATIC
	src/city.cc

	include/citycrc.h
	include/city.h
	src/config.h)
