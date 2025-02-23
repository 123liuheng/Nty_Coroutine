
CC = gcc
ECHO = echo

SUB_DIR = core/ sample/
ROOT_DIR = $(shell pwd)
OBJS_DIR = $(ROOT_DIR)/objs
BIN_DIR = $(ROOT_DIR)/bin

BIN = nty_server nty_client   nty_mysql_client nty_mysql_oper nty_rediscli
FLAG = -lpthread -O3 -lcrypto -lssl -lmysqlclient -lhiredis -ldl -I $(ROOT_DIR)/core  -I /usr/include/mysql/ -I /usr/local/include/hiredis/

CUR_SOURCE = ${wildcard *.c}
CUR_OBJS = ${patsubst %.c, %.o, %(CUR_SOURCE)}

export CC BIN_DIR OBJS_DIR ROOT_IDR FLAG BIN ECHO EFLAG

all : $(SUB_DIR) $(BIN)
.PHONY : all


$(SUB_DIR) : ECHO
	make -C $@

#DEBUG : ECHO
#	make -C bin

ECHO :
	@echo $(SUB_DIR)


nty_server : $(OBJS_DIR)/nty_socket.o $(OBJS_DIR)/nty_coroutine.o $(OBJS_DIR)/nty_epoll.o $(OBJS_DIR)/nty_schedule.o $(OBJS_DIR)/nty_server.o
	$(CC) -o $(BIN_DIR)/$@ $^ $(FLAG) 

nty_client : $(OBJS_DIR)/nty_socket.o $(OBJS_DIR)/nty_coroutine.o $(OBJS_DIR)/nty_epoll.o $(OBJS_DIR)/nty_schedule.o $(OBJS_DIR)/nty_client.o
	$(CC) -o $(BIN_DIR)/$@ $^ $(FLAG) 

nty_mysql_client : $(OBJS_DIR)/nty_socket.o $(OBJS_DIR)/nty_coroutine.o $(OBJS_DIR)/nty_epoll.o $(OBJS_DIR)/nty_schedule.o $(OBJS_DIR)/nty_mysql_client.o
	$(CC) -o $(BIN_DIR)/$@ $^ $(FLAG)

nty_mysql_oper : $(OBJS_DIR)/nty_socket.o $(OBJS_DIR)/nty_coroutine.o $(OBJS_DIR)/nty_epoll.o $(OBJS_DIR)/nty_schedule.o $(OBJS_DIR)/nty_mysql_oper.o
	$(CC) -o $(BIN_DIR)/$@ $^ $(FLAG)

nty_rediscli : $(OBJS_DIR)/nty_socket.o $(OBJS_DIR)/nty_coroutine.o $(OBJS_DIR)/nty_epoll.o $(OBJS_DIR)/nty_schedule.o $(OBJS_DIR)/nty_rediscli.o
	$(CC) -o $(BIN_DIR)/$@ $^ $(FLAG)

clean :
	rm -rf $(BIN_DIR)/* $(OBJS_DIR)/*

