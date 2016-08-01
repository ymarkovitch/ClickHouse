add_executable (zookeeper-dump-tree main.cpp ${SRCS})
target_link_libraries (zookeeper-dump-tree zkutil dbms Boost::program_options)
