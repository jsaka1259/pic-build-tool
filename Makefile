SRCS:=./src/*.c
CHIP:=12F1822
PROG:=led_blink.hex

TOOL:=PPK3# Pickit 3
IPE:=./tool/ipecmd.sh# Writer shell script

CC:=xc8-cc

OBJS:=*.p1 *.d *.s *.sdb *.cmf *.sym *.hxl *.lst *.rlf *.o *.elf
LOGS:=log.* MPLABXLog.xml*

DEFAULT: all

.PHONY: all
all: $(PROG) # Build
	@#

.PHONY: build
$(PROG) build: $(SRCS) # Build
	$(CC) -mcpu=$(CHIP) $(SRCS) -o $(PROG)

.PHONY: rebuild
rebuild: clean $(PROG) # Clean and Build
	@#

.PHONY: delobj
delobj:
	rm -f $(OBJS)

.PHONY: dellog
dellog:
	rm -f $(LOGS)

.PHONY: clean
clean: delobj dellog # DELOBJ and DELLOG and Delete PROG
	rm -f $(PROG)

.PHONY: write _write
write: _write# Write
	@#
_write: # Write PROG in CHIP using TOOL
	-$(IPE) -P$(CHIP) -T$(TOOL) -F$(PROG) -M

.PHONY: writew _writew
writew: _writew# Writew
	@#
_writew: # Write PROG in CHIP using TOOL. Power target from TOOL
	-$(IPE) -P$(CHIP) -T$(TOOL) -F$(PROG) -M -W

.PHONY: erase _erase
erase: _erase# Erase
	@#
_erase: # Erase Flash Device
	-$(IPE) -P$(CHIP) -T$(TOOL) -E

.PHONY: erasew _erasew
erasew: _erasew# Erasew
	@#
_erasew: # Erase Flash Device. Power target from TOOL
	-$(IPE) -P$(CHIP) -T$(TOOL) -E -W

.PHONY: verify _verify
verify: _verify# Verify
	@#
_verify: # Verify Device
	-$(IPE) -P$(CHIP) -T$(TOOL) -F$(PROG) -Y

.PHONY: verifyw _verifyw
verifyw: _verifyw# Verifyw
	@#
_verifyw: # Verify Device. Power target from TOOL
	-$(IPE) -P$(CHIP) -T$(TOOL) -F$(PROG) -Y -W

.PHONY: blank _blank
blank: _blank# Blank
	@#
_blank: # Blank Check Device
	-$(IPE) -P$(CHIP) -T$(TOOL) -C

.PHONY: blankw _blankw
blankw: _blankw# Blankw
	@#
_blankw: # Blank Check Device. Power target from TOOL
	-$(IPE) -P$(CHIP) -T$(TOOL) -C -W

