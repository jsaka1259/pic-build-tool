CHIP   := 12F1822

SRCDIR := src
SRCS   := $(SRCDIR)/*.c

OUTDIR := build
LOGS   := log.* MPLABXLog.xml*
BIN    := $(OUTDIR)/led_blink.hex

# Pickit 3
TOOL   := PPK3

# Writer shell script
IPE    := ./tool/ipecmd.sh

CC     := xc8-cc
CFLAGS := -mwarn=-9

.PHONY: rebuild clean write erase verify blank
.PHONY: writew erasew verifyw blankw

# Build
$(BIN): $(SRCS)
	@if [ ! -e `dirname $@` ]; then mkdir -p `dirname $@`; fi
	$(CC) -mcpu=$(CHIP) $(CFLAGS) -o $@ $^

# Clean and Build
rebuild: clean $(BIN)

# Delete OUTDIR and LOGS
clean:
	rm -rf $(OUTDIR)

# Write BIN in CHIP using TOOL
write:
	$(IPE) -P$(CHIP) -T$(TOOL) -F$(BIN) -M
	@mv $(LOGS) $(OUTDIR)
# Erase Flash Device
erase:
	$(IPE) -P$(CHIP) -T$(TOOL) -E
	@mv $(LOGS) $(OUTDIR)
# Verify Device
verify:
	$(IPE) -P$(CHIP) -T$(TOOL) -F$(BIN) -Y
	@mv $(LOGS) $(OUTDIR)
# Blank Check Device
blank:
	$(IPE) -P$(CHIP) -T$(TOOL) -C
	@mv $(LOGS) $(OUTDIR)/

# Write BIN in CHIP using TOOL. Power target from TOOL
writew:
	$(IPE) -P$(CHIP) -T$(TOOL) -F$(BIN) -M -W
	@mv $(LOGS) $(OUTDIR)
# Erase Flash Device. Power target from TOOL
erasew:
	-$(IPE) -P$(CHIP) -T$(TOOL) -E -W
	@mv $(LOGS) $(OUTDIR)
# Verify Device. Power target from TOOL
verifyw:
	-$(IPE) -P$(CHIP) -T$(TOOL) -F$(BIN) -Y -W
	@mv $(LOGS) $(OUTDIR)
# Blank Check Device. Power target from TOOL
blankw:
	-$(IPE) -P$(CHIP) -T$(TOOL) -C -W
	@mv $(LOGS) $(OUTDIR)
