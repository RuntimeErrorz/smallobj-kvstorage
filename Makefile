# 定义编译器和编译选项
CXX = g++
CXXFLAGS = -std=c++17 -fPIC -pthread -O2

# 定义目标文件
TARGET_LIB = libkvstore.so
TARGET_EXEC = main stress
STATIC_EXEC = main_static stress_static

# 定义源文件
SRCS_LIB = kvstore.cpp
SRCS_MAIN = main.cpp
SRCS_STRESS = stress.cpp

# 定义头文件目录
INCLUDES = -I.

# 默认目标
all: $(TARGET_LIB) $(TARGET_EXEC)

# 编译共享库
$(TARGET_LIB):
	$(CXX) $(CXXFLAGS) -shared -o $@ $(SRCS_LIB)

# 编译可执行文件并链接共享库
main:
	$(CXX) $(CXXFLAGS) -o $@ $(SRCS_MAIN) -L. -lkvstore

stress:
	$(CXX) $(CXXFLAGS) -g -o $@ $(SRCS_STRESS) -L. -lkvstore

# 静态编译可执行文件
main_static:
	$(CXX) -std=c++17 -pthread -O2 -o $@ $(SRCS_MAIN) $(SRCS_LIB)

stress_static:
	$(CXX) -std=c++17 -pthread -o $@ $(SRCS_STRESS) $(SRCS_LIB)


# 清理生成的文件
clean:
	rm -f $(TARGET_LIB) $(TARGET_EXEC) $(STATIC_EXEC)

.PHONY: all clean