SDIR   := src/
SRCS   := $(SDIR)*.c
CHIP   := 12F1822
PROG   := led_blink.hex

TOOL   := PPK3# Pickit 3
IPE    := ./tool/ipecmd.sh# Writer shell script

CC     := xc8-cc
CFLAGS := -w
RM     := rm

OBJS   := *.p1 *.d *.s *.sdb
OBJS   += *.cmf *.sym *.hxl *.lst
OBJS   += *.rlf *.o *.elf
LOGS   := log.* MPLABXLog.xml*

DEFAULT: all

.PHONY: all
all: $(PROG) # Build
	@#

$(PROG): $(SRCS)# Build
	$(CC) -mcpu=$(CHIP) $(CFLAGS) $^ -o $@

.PHONY: rebuild
rebuild: clean $(PROG) # Clean and Build
	@#

.PHONY: delobj
delobj:
	$(RM) -f $(OBJS)

.PHONY: dellog
dellog:
	$(RM) -f $(LOGS)

.PHONY: clean
clean: delobj dellog # DELOBJ and DELLOG and Delete PROG
	$(RM) -f $(PROG)

.PHONY: write
write: # Write PROG in CHIP using TOOL
	-$(IPE) -P$(CHIP) -T$(TOOL) -F$(PROG) -M

.PHONY: writew
writew: # Write PROG in CHIP using TOOL. Power target from TOOL
	-$(IPE) -P$(CHIP) -T$(TOOL) -F$(PROG) -M -W

.PHONY: erase
erase: # Erase Flash Device
	-$(IPE) -P$(CHIP) -T$(TOOL) -E

.PHONY: erasew
erasew: # Erase Flash Device. Power target from TOOL
	-$(IPE) -P$(CHIP) -T$(TOOL) -E -W

.PHONY: verify
verify: # Verify Device
	-$(IPE) -P$(CHIP) -T$(TOOL) -F$(PROG) -Y

.PHONY: verifyw
verifyw: # Verify Device. Power target from TOOL
	-$(IPE) -P$(CHIP) -T$(TOOL) -F$(PROG) -Y -W

.PHONY: blank
blank: # Blank Check Device
	-$(IPE) -P$(CHIP) -T$(TOOL) -C

.PHONY: blankw
blankw: # Blank Check Device. Power target from TOOL
	-$(IPE) -P$(CHIP) -T$(TOOL) -C -W
