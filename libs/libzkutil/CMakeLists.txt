add_library(zkutil STATIC
	src/ZooKeeper.cpp
	src/Lock.cpp
	src/SingleBarrier.cpp
	src/RWLock.cpp
	src/ZooKeeperHolder.cpp

	include/zkutil/Increment.h
    include/zkutil/LeaderElection.h
    include/zkutil/KeeperException.h
    include/zkutil/Common.h
    include/zkutil/Lock.h
    include/zkutil/SingleBarrier.h
    include/zkutil/RWLock.h
    include/zkutil/ZooKeeper.h
    include/zkutil/Types.h
    include/zkutil/ZooKeeperHolder.h)

target_link_libraries(zkutil INTERFACE
    zookeeper
    PocoFoundation
    -pthread)

add_subdirectory (src)
