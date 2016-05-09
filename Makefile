TRACE_DIR:=traces

TEST_FILES := $(wildcard test_*.vhdl)
TRACE_LIST := $(TEST_FILES:%.vhdl=$(TRACE_DIR)/%.ghw)

.PHONY: all
all: $(TRACE_LIST) 

test_fifo: test_fifo.o fifo.o
	ghdl -m $@

%.o: %.vhdl
	ghdl -a $<

$(TRACE_DIR)/test_%.ghw: test_%
	$(maketargetdir)
	./$< --wave=$@

define maketargetdir
	-@mkdir -p $(dir $@) > /dev/null 2>&1
endef

.PHONY: clean
clean: tidy
	rm -rf $(TRACE_DIR)

.PHONY: tidy
tidy: 
	rm -rf *.o
	rm -rf *.ghw
	rm -rf *.cf
	rm -rf test_fifo
