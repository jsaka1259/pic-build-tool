HEX    := led_blink
CHIP   := 12F1822

SRCDIR := src
SRCS   := $(shell find $(SRCDIR) -type f -name *.c)
OUTDIR := build
BIN    := $(OUTDIR)/$(HEX).hex
LOGS   := log.* MPLABXLog.xml*

# Set writing shell script path
IPE    := ./tool/ipecmd.sh

# Set writing TOOL (Pickit3)
TOOL   := PPK3

# Power target from TOOL
VDD    := 5.0

# Compiler
CC     := xc8-cc
CFLAGS := -mwarn=-9

.PHONY: rebuild clean
.PHONY: write   erase  verify  blank
.PHONY: writew  erasew verifyw blankw

# Build
$(BIN): $(SRCS)
	@if [ ! -e $(OUTDIR) ]; then mkdir -p $(OUTDIR); fi
	$(CC) -mcpu=$(CHIP) $(CFLAGS) -o $@ $^

# Clean and Build
rebuild: clean $(BIN)

# Delete OUTDIR and LOGS
clean:
	rm -rf $(OUTDIR)


# Write BIN in CHIP using TOOL
write:
	@if [ ! -e $(OUTDIR) ]; then mkdir -p $(OUTDIR); fi
	$(IPE) -P$(CHIP) -T$(TOOL) -F$(BIN) -M
	@mv $(LOGS) $(OUTDIR)

# Erase Flash Device
erase:
	@if [ ! -e $(OUTDIR) ]; then mkdir -p $(OUTDIR); fi
	$(IPE) -P$(CHIP) -T$(TOOL) -E
	@mv $(LOGS) $(OUTDIR)

# Verify Device
verify:
	@if [ ! -e $(OUTDIR) ]; then mkdir -p $(OUTDIR); fi
	$(IPE) -P$(CHIP) -T$(TOOL) -F$(BIN) -Y
	@mv $(LOGS) $(OUTDIR)

# Blank Check Device
blank:
	@if [ ! -e $(OUTDIR) ]; then mkdir -p $(OUTDIR); fi
	$(IPE) -P$(CHIP) -T$(TOOL) -C
	@mv $(LOGS) $(OUTDIR)/


# Power from TOOL
writew:
	@if [ ! -e $(OUTDIR) ]; then mkdir -p $(OUTDIR); fi
	$(IPE) -P$(CHIP) -T$(TOOL) -F$(BIN) -M -W$(VDD)
	@mv $(LOGS) $(OUTDIR)

erasew:
	@if [ ! -e $(OUTDIR) ]; then mkdir -p $(OUTDIR); fi
	$(IPE) -P$(CHIP) -T$(TOOL) -E -W$(VDD)
	@mv $(LOGS) $(OUTDIR)

verifyw:
	@if [ ! -e $(OUTDIR) ]; then mkdir -p $(OUTDIR); fi
	$(IPE) -P$(CHIP) -T$(TOOL) -F$(BIN) -Y -W$(VDD)
	@mv $(LOGS) $(OUTDIR)

blankw:
	@if [ ! -e $(OUTDIR) ]; then mkdir -p $(OUTDIR); fi
	$(IPE) -P$(CHIP) -T$(TOOL) -C -W$(VDD)
	@mv $(LOGS) $(OUTDIR)
