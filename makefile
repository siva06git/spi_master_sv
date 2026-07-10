# ==========================================================
# Generic Makefile for SystemVerilog + Icarus Verilog
# Usage:
#   make TOP=piso_tb
#   make TOP=sipo_tb wave
#   make TOP=spi_top_tb run
#   make clean
# ==========================================================

TB_DIR  = testbench
OUT_DIR = output

# Testbench name (must be provided)
TOP ?= piso_tb

# Automatically include every .sv file inside rtl/
RTL := $(wildcard rtl/*.sv)
TB  := $(TB_DIR)/$(TOP).sv

OUT = $(OUT_DIR)/$(TOP)

all: run

compile:
	mkdir -p $(OUT_DIR)
	iverilog -g2012 -o $(OUT).out $(RTL) $(TB)

run: compile
	vvp $(OUT).out

wave: run
	gtkwave $(OUT).vcd

clean:
	rm -f $(OUT_DIR)/*.out $(OUT_DIR)/*.vcd