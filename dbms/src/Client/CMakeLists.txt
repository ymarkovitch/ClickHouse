find_library(READLINE_LIB readline)
find_library(LIBEDIT_LIB edit)

if(READLINE_LIB)
	add_definitions(-D USE_READLINE)
	set(LINE_EDITING_LIBS readline)
	message(STATUS "Using line editing libraries: ${LINE_EDITING_LIBS}")
elseif(LIBEDIT_LIB)
	add_definitions(-D USE_LIBEDIT)
	set(LINE_EDITING_LIBS edit curses termcap)
	message(STATUS "Using line editing libraries: ${LINE_EDITING_LIBS}")
else()
	message(STATUS "Not using any library for line editing.")
endif()

add_executable(clickhouse-client Client.cpp)
add_executable(clickhouse-benchmark Benchmark.cpp)

target_link_libraries (clickhouse-client dbms ${LINE_EDITING_LIBS} Boost::program_options)
target_link_libraries (clickhouse-benchmark dbms Boost::program_options)

install(TARGETS clickhouse-client RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}" COMPONENT clickhouse-client)
install(FILES config.xml DESTINATION "${CMAKE_INSTALL_SYSCONFDIR}/clickhouse-client"  COMPONENT clickhouse-client)

install(TARGETS clickhouse-benchmark RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}" COMPONENT clickhouse-benchmark)

IF(TESTS)
	add_subdirectory (tests)
ENDIF(TESTS)
