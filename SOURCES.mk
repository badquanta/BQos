BQos_SRC_DIR  := src/BQos
LIBC_SRC_DIR  := src/libc

BQos_CPP_SRCS := $(wildcard $(BQos_SRC_DIR)/*.cpp)
BQos_CPP_SRCS += $(wildcard $(BQos_SRC_DIR)/*/*.cpp)
BQos_CPP_SRCS += $(wildcard $(BQos_SRC_DIR)/*/*/*.cpp)

LIBC_C_SRCS := $(wildcard $(LIBC_SRC_DIR)/*.c)
LIBC_C_SRCS += $(wildcard $(LIBC_SRC_DIR)/*/*.c)
LIBC_C_SRCS += $(wildcard $(LIBC_SRC_DIR)/*/*.c)

LIBC_H_SRCS := $(wildcard $(LIBC_SRC_DIR)/*.h)
LIBC_H_SRCS += $(wildcard $(LIBC_SRC_DIR)/*/*.h)
LIBC_H_SRCS += $(wildcard $(LIBC_SRC_DIR)/*/*.h)

BQos_HPP_SRCS := $(wildcard $(BQos_SRC_DIR)/*.hpp)
BQos_HPP_SRCS += $(wildcard $(BQos_SRC_DIR)/*/*.hpp)
BQos_HPP_SRCS += $(wildcard $(BQos_SRC_DIR)/*/*/*.hpp)

BQos_GAS_SRCS := $(wildcard $(BQos_SRC_DIR)/*.s)
BQos_GAS_SRCS += $(wildcard $(BQos_SRC_DIR)/*/*.s)
BQos_GAS_SRCS += $(wildcard $(BQos_SRC_DIR)/*/*/*.s)
dump-source-dir:
	@echo "BQos_SRC_DIR: $(BQos_SRC_DIR)"
dump-cpp-sources:
	@echo "CPP: $(BQos_CPP_SRCS)"
dump-c-sources:
	@echo "C: $(LIBC_C_SRCS)"
dump-hpp-sources:
	@echo "HPP: $(BQos_HPP_SRCS)"
dump-gas-sources:
	@echo "GAS: $(BQos_GAS_SRCS)"