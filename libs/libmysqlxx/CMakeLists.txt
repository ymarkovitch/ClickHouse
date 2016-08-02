add_library (mysqlxx STATIC
	src/Connection.cpp
	src/Query.cpp
	src/ResultBase.cpp
	src/StoreQueryResult.cpp
	src/UseQueryResult.cpp
	src/Value.cpp
	src/PoolWithFailover.cpp

	include/mysqlxx/Connection.h
	include/mysqlxx/Exception.h
	include/mysqlxx/Manip.h
	include/mysqlxx/mysqlxx.h
	include/mysqlxx/Null.h
	include/mysqlxx/Pool.h
	include/mysqlxx/PoolWithFailover.h
	include/mysqlxx/Query.h
	include/mysqlxx/ResultBase.h
	include/mysqlxx/Row.h
	include/mysqlxx/StoreQueryResult.h
	include/mysqlxx/Transaction.h
	include/mysqlxx/Types.h
	include/mysqlxx/UseQueryResult.h
	include/mysqlxx/Value.h
        )

target_link_libraries (mysqlxx
    PUBLIC
    ${MYSQL_LIB}
    common
    ssl
    crypto
    z
    dl)

IF(TESTS)
	add_subdirectory (src/tests)
ENDIF(TESTS)
