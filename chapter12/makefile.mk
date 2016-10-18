#
# example of utilization:
# make -f makefile.mk build EXE=ParsingTest1 OBJS=ParsingTest1.o
#

include $(ORACLE_HOME)/rdbms/lib/env_rdbms.mk

build: $(LIBCLNTSH) $(OBJS)
	$(BUILDEXE64)
	$(RM) -f $(OBJS)

