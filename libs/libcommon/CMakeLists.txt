SET(REVISIONFILE ${CMAKE_CURRENT_BINARY_DIR}/src/revision.h)

ADD_CUSTOM_COMMAND(
    OUTPUT ${REVISIONFILE}
    COMMAND bash -f -v -x ${CMAKE_CURRENT_SOURCE_DIR}/src/create_revision.sh ${REVISIONFILE} ${USE_DBMS_TCP_PROTOCOL_VERSION_AS_CLICKHOUSE_REVISION}
)

set_source_files_properties(
	src/ClickHouseRevision.cpp PROPERTIES OBJECT_DEPENDS ${REVISIONFILE}
)

include_directories (${CMAKE_CURRENT_BINARY_DIR}/src/)

add_library (common STATIC
	src/DateLUT.cpp
	src/DateLUTImpl.cpp
	src/ClickHouseRevision.cpp
	src/JSON.cpp

	include/common/ApplicationServerExt.h
	include/common/Common.h
	include/common/DateLUT.h
	include/common/DateLUTImpl.h
	include/common/LocalDate.h
	include/common/LocalDateTime.h
	include/common/ErrorHandlers.h
	include/common/likely.h
	include/common/logger_useful.h
	include/common/MultiVersion.h
	include/common/ClickHouseRevision.h
	include/common/singleton.h
	include/common/strong_typedef.h
	include/common/JSON.h

	include/ext/bit_cast.hpp
	include/ext/collection_cast.hpp
	include/ext/enumerate.hpp
	include/ext/function_traits.hpp
	include/ext/identity.hpp
	include/ext/map.hpp
	include/ext/range.hpp
	include/ext/scope_guard.hpp
	include/ext/size.hpp
	include/ext/unlock_guard.hpp

	${REVISIONFILE}
)

add_library(malloc_library INTERFACE)

# TESTIRT-3687 DISABLE_LIBTCMALLOC - when testing for memory leaks, disable libtcmalloc
IF($ENV{DISABLE_LIBTCMALLOC})
        message(STATUS "Disabling libtcmalloc for valgrind better analysis")
ELSE()
	IF($ENV{DEBUG_LIBTCMALLOC})
		message(STATUS "Link libtcmalloc_minimal_debug for testing")
                target_link_libraries(malloc_library INTERFACE tcmalloc_minimal_debug)
	ELSE()
		message(STATUS "Link libtcmalloc_minimal")
                target_link_libraries(malloc_library INTERFACE tcmalloc_minimal_internal)
	ENDIF()
ENDIF()

target_link_libraries (common
    INTERFACE

    pocoext
    malloc_library
    glib-2.0
    icui18n icuuc icudata
    -pthread rt dl)

IF(TESTS)
	add_subdirectory (src/tests)
ENDIF(TESTS)
