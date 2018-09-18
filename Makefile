SRCS:=./src/*.c
CHIP:=12F1822
PROG:=led_blink.hex

TOOL:=PPK3# Pickit 3
IPE:=./tool/ipecmd.sh# Writer shell script

CC:=xc8-cc

ETC:=*.md LICENSE Makefile ./circuit/*
KEEP:=$(ETC) $(SRCS) $(PROG) $(IPE)
REG:=`echo $(KEEP) | tr ' ' '\n' | sed -e "s/^/\^/g" -e "s/\$$/$$/g" | tr '\n' '|' | sed -e "s/|\$$//g"`

DEFAULT: all

.PHONY: all
all: $(PROG) ir # Build and IR
	@#

.PHONY: build
$(PROG) build: $(SRCS) # Build
	$(CC) -mcpu=$(CHIP) $(SRCS) -o $(PROG)

.PHONY: rebuild
rebuild: clean $(PROG) # Clean and Build
	@#

.PHONY: ir
ir: # Delete except for KEEP
	@$(eval IR:=$(shell ls -1F | grep -v / | sed -e "s/\*\$$//g" | grep -vE "$(REG)"))
	@if [ "$(IR)" != "" ]; then echo "rm -f $(IR)"; rm -f $(IR); fi

.PHONY: clean
clean: ir # IR and Delete PROG
	@if [ "$(PROG)" != "" ]; then echo "rm -f $(PROG)"; rm -f $(PROG); fi

.PHONY: write _write
write: _write ir # Write and IR
	@#
_write: # Write PROG in CHIP using TOOL
	-$(IPE) -P$(CHIP) -T$(TOOL) -F$(PROG) -M

.PHONY: writew _writew
writew: _writew ir # Writew and IR
	@#
_writew: # Write PROG in CHIP using TOOL. Power target from TOOL
	-$(IPE) -P$(CHIP) -T$(TOOL) -F$(PROG) -M -W

.PHONY: erase _erase
erase: _erase ir # Erase and IR
	@#
_erase: # Erase Flash Device
	-$(IPE) -P$(CHIP) -T$(TOOL) -E

.PHONY: erasew _erasew
erasew: _erasew ir # Erasew and IR
	@#
_erasew: # Erase Flash Device. Power target from TOOL
	-$(IPE) -P$(CHIP) -T$(TOOL) -E -W

.PHONY: verify _verify
verify: _verify ir # Verify and IR
	@#
_verify: # Verify Device
	-$(IPE) -P$(CHIP) -T$(TOOL) -F$(PROG) -Y

.PHONY: verifyw _verifyw
verifyw: _verifyw ir # Verifyw and IR
	@#
_verifyw: # Verify Device. Power target from TOOL
	-$(IPE) -P$(CHIP) -T$(TOOL) -F$(PROG) -Y -W

.PHONY: blank _blank
blank: _blank ir # Blank and IR
	@#
_blank: # Blank Check Device
	-$(IPE) -P$(CHIP) -T$(TOOL) -C

.PHONY: blankw _blankw
blankw: _blankw ir # Blankw and IR
	@#
_blankw: # Blank Check Device. Power target from TOOL
	-$(IPE) -P$(CHIP) -T$(TOOL) -C -W

