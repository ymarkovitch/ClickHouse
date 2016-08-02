# - Attempt to find MySQL client library/headers.
# Defines the following variables:
# MYSQL_FOUND		- If false, do not try to use MySQL.
# MYSQL_INCLUDE_DIR 	- Where to find MySQL client public headers (mysql.h, etc.)
# MYSQL_LIB	        - The libraries to link against.
# MYSQL_LIB_DIR         - Libraries directory.
# MYSQL_VERSION_STRING	- MySQL version string from the header file.
#
# Created by RenatoUtsch based on eAthena implementation.
#
# Please note that this module only supports Windows and Linux officially, but
# should work on all UNIX-like operational systems too.
#
#=============================================================================
# Copyright 2012 RenatoUtsch
# Copyright 2016 Yakov Markovitch
#
# Distributed under the OSI-approved BSD License (the "License");
# see accompanying file Copyright.txt for details.
#
# This software is distributed WITHOUT ANY WARRANTY; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the License for more information.
#=============================================================================

if(WIN32)
    find_path(MYSQL_INCLUDE_DIR
	NAMES "mysql.h"
	PATHS "$ENV{PROGRAMFILES}/MySQL/*/include"
	"$ENV{PROGRAMFILES(x86)}/MySQL/*/include"
	"$ENV{SYSTEMDRIVE}/MySQL/*/include")

    find_library(MYSQL_LIB
	NAMES "mysqlclient" "mysqlclient_r"
	PATHS "$ENV{PROGRAMFILES}/MySQL/*/lib"
	"$ENV{PROGRAMFILES(x86)}/MySQL/*/lib"
	"$ENV{SYSTEMDRIVE}/MySQL/*/lib")
else()
    find_path(MYSQL_INCLUDE_DIR
	NAMES "mysql.h"
	PATHS
	$ENV{MYSQL_INCLUDE_DIR}
	$ENV{MYSQL_DIR}/include
        "/usr/include/mysql"
	"/usr/local/include/mysql"
	"/usr/mysql/include/mysql"
        )

    find_library(MYSQL_LIB
	NAMES "mysqlclient_r" "mysqlclient"
	PATHS
	$ENV{MYSQL_DIR}/libmysql_r/.libs
	$ENV{MYSQL_DIR}/lib
	$ENV{MYSQL_DIR}/lib/mysql
	"/lib64/mysql"
        "/lib/mysql"
	"/usr/lib64/mysql"
	"/usr/lib/mysql"
	"/usr/local/lib64/mysql"
	"/usr/local/lib/mysql"
	"/usr/mysql/lib64/mysql"
	"/usr/mysql/lib/mysql"
        "/opt/mysql/mysql/lib"
        "/opt/mysql/mysql/lib/mysql"
        )
endif()

if(MYSQL_INCLUDE_DIR AND EXISTS ${MYSQL_INCLUDE_DIR}/mysql_version.h)

    file(STRINGS ${MYSQL_INCLUDE_DIR}/mysql_version.h
	MYSQL_VERSION_H REGEX "^#define[ \t]+MYSQL_SERVER_VERSION[ \t]+\"[^\"]+\".*$")
    string(REGEX REPLACE
	"^.*MYSQL_SERVER_VERSION[ \t]+\"([^\"]+)\".*$" "\\1" MYSQL_VERSION_STRING
	"${MYSQL_VERSION_H}")
endif()

# handle the QUIETLY and REQUIRED arguments and set MYSQL_FOUND to TRUE if
# all listed variables are TRUE
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(MYSQL
    REQUIRED_VARS	MYSQL_LIB MYSQL_INCLUDE_DIR
    VERSION_VAR		MYSQL_VERSION_STRING)

get_filename_component(MYSQL_LIB_DIR ${MYSQL_LIB} PATH)
mark_as_advanced(MYSQL_INCLUDE_DIR MYSQL_LIB_DIR MYSQL_LIB)
