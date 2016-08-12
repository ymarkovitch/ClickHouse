add_executable (compressor main.cpp)
target_link_libraries (compressor dbms Boost::program_options)

install(TARGETS compressor RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}" COMPONENT compressor)


add_executable (zstd_test zstd_test.cpp)
target_link_libraries (zstd_test zstd)
