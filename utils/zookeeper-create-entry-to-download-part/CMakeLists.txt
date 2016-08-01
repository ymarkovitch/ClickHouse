add_executable (zookeeper-create-entry-to-download-part main.cpp ${SRCS})
target_link_libraries (zookeeper-create-entry-to-download-part zkutil dbms Boost::program_options)
