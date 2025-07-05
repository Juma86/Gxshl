.PHONY: default log run build prepare clean

INCLUDES    ?= .

HEADER_DIRS  = $(dir $(shell find . | grep /Header/))
LIB_DIRS     = $(dir $(shell find . -name '*.a') $(shell find . -name '*.so'))

CC          := gcc
CFLAGS       = `pkg-config --cflags $(INCLUDES)` -Wall -Wextra -pedantic -Werror $(HEADER_DIRS:%=-I%) -fno-stack-protector -fno-builtin -std=c23 -s -Os

LD          := ld
LDFLAGS      = --entry=_start -lgxstl $(LIB_DIRS:%=-L%)

SRC_DIR     := Source/
OUT_DIR     := Bin/
TMP_DIR     := Temp/
OBJ_DIR     := $(TMP_DIR)Object/
LIB_DIR     := Libraries/
RES_DIR     := Resources/

POP_LIB     := populate-libs

TARGET      := gxshl

SRCS         = $(shell find $(SRC_DIR) -name '*.c')
OBJS         = $(SRCS:$(SRC_DIR)%.c=$(OBJ_DIR)%.c.o)

CPY         := cp -r
MKD         := mkdir -p
DEL         := rm -fr
CHD         := cd

default: run

log:
	@echo INCLUDES "   = $(INCLUDES)"
	@echo HEADER_DIRS "= $(HEADER_DIRS)"
	@echo LIB_DIRS "   = $(LIB_DIRS)"
	@echo CC "         = $(CC)"
	@echo CFLAGS "     = $(CFLAGS)"
	@echo LDFLAGS "    = $(LDFLAGS)"
	@echo SRC_DIR "    = $(SRC_DIR)"
	@echo OUT_DIR "    = $(OUT_DIR)"
	@echo TMP_DIR "    = $(TMP_DIR)"
	@echo OBJ_DIR "    = $(OBJ_DIR)"
	@echo TARGET "     = $(TARGET)"
	@echo SRCS "       = $(SRCS)"
	@echo OBJS "       = $(OBJS)"
	@echo CPY "        = $(CPY)"
	@echo MKD "        = $(MKD)"
	@echo DEL "        = $(DEL)"

run: build
	$(OUT_DIR)$(TARGET)

build: prepare $(OUT_DIR)$(TARGET)
	$(CPY) $(TMP_DIR)$(OUT_DIR) .

prepare: $(TMP_DIR) $(OBJ_DIR) $(TMP_DIR)$(OUT_DIR) $(OUT_DIR) $(LIB_DIR)

$(LIB_DIR):
	$(MKD) $(LIB_DIR)
	$(CPY) $(RES_DIR)$(POP_LIB) $(LIB_DIR) && $(CHD) $(LIB_DIR) && ./$(POP_LIB) && $(DEL) ./$(POP_LIB)
	$(MAKE) -C $(LIB_DIR)* build

$(TMP_DIR):
	$(MKD) $(TMP_DIR)

$(OBJ_DIR):
	$(MKD) $(OBJ_DIR)

$(TMP_DIR)$(OUT_DIR): $(TMP_DIR)
	$(MKD) $(TMP_DIR)$(OUT_DIR)

$(OUT_DIR):
	$(MKD) $(OUT_DIR)

clean:
	$(DEL) $(TMP_DIR) $(OBJ_DIR) $(OUT_DIR) $(LIB_DIR)

del-deps:
	$(DEL) $(LIB_DIR)

$(OUT_DIR)$(TARGET): $(OBJS)
	$(LD) $(OBJS) -o $(TMP_DIR)$(OUT_DIR)$(TARGET) $(LDFLAGS)

$(OBJ_DIR)%.c.o: $(SRC_DIR)%.c
	$(CC) -c -o $@ $< $(CFLAGS)