add_executable (wikistat-loader main.cpp ${SRCS})
target_link_libraries (wikistat-loader dbms Boost::program_options)
