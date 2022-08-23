##
## ATOS PROJECT 2022
## MAKEFILE
## File description:
## Wow, such make, much file!
##

SLURM_ROOT_DIR = /usr
SLURM_INC_DIR = /root/SLURM/slurm.build
SLURM_LIB_DIR = /usr/lib64/slurm
SLURM_BUILD = 21.08.8-2
SLURM_BUILD_DIR = /root/rpmbuild/BUILD/slurm-$(SLURM_BUILD)

PLUGIN_TYPE = acct_gather_profile
PLUGIN_NAME = demeter
PLUGIN_FILE = $(PLUGIN_TYPE)_$(PLUGIN_NAME).so

SRC_FILES = src/demeter.c							\
			src/gatherers/gather_cgroup.c			\
			src/gatherers/gather_logs.c				\
			src/gatherers/cgroup/get_from_files.c	\
			src/loggers/logger.c					\
			src/gatherers/logs/read_logs.c			\
			src/loggers/cgroup/log_cgroup.c			\
			src/tools/get_time_str.c				\
			src/tools/read_conf.c					\
			src/tools/get_job_info.c				\
			src/tools/linked_list.c					\
			src/tools/free/im_free.c				\

CC      = gcc
CFLAGS  ?= -Wall -fPIC -g -I$(SLURM_INC_DIR) -I$(SLURM_BUILD_DIR) -Iinclude
LDFLAGS ?= --shared -L.

all: $(PLUGIN_FILE)

default: $(PLUGIN_FILE)

$(PLUGIN_FILE): $(SRC_FILES)
	$(CC) $(CFLAGS) $(LDFLAGS) $^ -o $@

clean:
	rm -f $(PLUGIN_FILE)

re: clean all