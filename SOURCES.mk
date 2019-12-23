SOURCE_DIR  := src/os

CPP_SOURCES := $(wildcard $(SOURCE_DIR)/*.cpp)
CPP_SOURCES += $(wildcard $(SOURCE_DIR)/*/*.cpp)
CPP_SOURCES += $(wildcard $(SOURCE_DIR)/*/*/*.cpp)

HPP_SOURCES := $(wildcard $(SOURCE_DIR)/*.hpp)
HPP_SOURCES += $(wildcard $(SOURCE_DIR)/*/*.hpp)

GAS_SOURCES := $(wildcard $(SOURCE_DIR)/*.s)
GAS_SOURCES += $(wildcard $(SOURCE_DIR)/*/*.s)
