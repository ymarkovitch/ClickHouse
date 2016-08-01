if (BUILD_SHARED_LIBS)
  find_library(READLINE_LIB NAMES libreadline.so libreadline.a)
  find_library(LIBEDIT_LIB  NAMES libedit.so libedit.a)
else()
  find_library(READLINE_LIB NAMES libreadline.a)
  find_library(LIBEDIT_LIB  NAMES libedit.a)
endif()

if(READLINE_LIB)
	add_definitions(-D USE_READLINE)
	set(LINE_EDITING_LIBS ${READLINE_LIB} termcap)
	message(STATUS "Using line editing libraries: ${LINE_EDITING_LIBS}")
elseif(LIBEDIT_LIB)
	add_definitions(-D USE_LIBEDIT)
	set(LINE_EDITING_LIBS ${LIBEDIT_LIB} curses termcap)
	message(STATUS "Using line editing libraries: ${LINE_EDITING_LIBS}")
else()
	message(STATUS "Not using any library for line editing.")
endif()

add_executable(clickhouse-client Client.cpp)
add_executable(clickhouse-benchmark Benchmark.cpp)

target_link_libraries (clickhouse-client dbms ${LINE_EDITING_LIBS} Boost::program_options)
target_link_libraries (clickhouse-benchmark dbms Boost::program_options)

INSTALL(TARGETS clickhouse-client RUNTIME DESTINATION bin COMPONENT clickhouse-client)
INSTALL(FILES config.xml DESTINATION /etc/clickhouse-client  COMPONENT clickhouse-client)

INSTALL(TARGETS clickhouse-benchmark RUNTIME DESTINATION bin  COMPONENT clickhouse-benchmark)

IF(TESTS)
	add_subdirectory (tests)
ENDIF(TESTS)
