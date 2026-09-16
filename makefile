TOP = spi_registers_tb

RTL = $(wildcard rtl/*.sv)
TB  = testbench/spi_registers_tb.sv

VERILATOR = verilator

FLAGS = --binary --timing --trace --Wall

all: run

build:
	mkdir -p output
	$(VERILATOR) $(FLAGS) $(RTL) $(TB) --top-module $(TOP)

run: build
	./obj_dir/V$(TOP)

wave: run
	gtkwave output/spi_registers.vcd

clean:
	rm -rf obj_dir
	rm -f output/*.vcd