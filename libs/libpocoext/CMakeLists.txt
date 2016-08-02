add_library (pocoext STATIC
	src/LevelFilterChannel.cpp
	src/ThreadNumber.cpp

	include/Poco/Ext/LevelFilterChannel.h
	include/Poco/Ext/ThreadNumber.h)

target_link_libraries(pocoext PUBLIC
        PocoUtil PocoNet PocoXML PocoFoundation)
