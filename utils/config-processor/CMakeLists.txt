add_executable (config-processor config-processor.cpp)
target_link_libraries (config-processor daemon)

install(TARGETS config-processor RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}" COMPONENT config-processor)
