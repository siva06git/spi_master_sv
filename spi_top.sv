module spi_top #(
    parameter WIDTH = 8,
    parameter SIZE = 16,
    parameter FIFO_DEPTH = 8,
    parameter IR_SIZE = 8
)(
    input logic clk,
    input logic rst_n,

    // External SPI Pins
    output logic sclk,
    output logic mosi,
    input logic miso,
    output logic cs_n,

    // Host Buffer Interface
    input logic [2*SIZE-1:0] reg_data,
    input logic [WIDTH-1:0] tx_data_in,
    input logic tx_w_en,
    output logic tx_fifo_full,
    output logic tx_fifo_empty,
    output logic tx_fifo_done,

    output logic [WIDTH-1:0] rx_data_out,
    input logic rx_r_en,
    output logic rx_fifo_full,
    output logic rx_fifo_empty,
    output logic rx_fifo_done,

    // Interrupt Controls & Output
    input logic [IR_SIZE-1:0] irq_en,
    output logic irq,
    output logic busy
);

    // Internal Wires
    logic msb;
    logic cpol;
    logic cpha;
    logic [WIDTH-1:0] word_size;
    logic [WIDTH-1:0] div_value;

    logic [WIDTH-1:0] tx_fifo_data_out;
    logic tx_fifo_read;
    logic tx_fifo_done_internal;

    logic [WIDTH-1:0] sipo_data_out;
    logic rx_fifo_write;
    logic rx_fifo_done_internal;

    logic piso_busy;
    logic piso_load;
    logic piso_shift;

    logic sipo_busy;
    logic sipo_shift;

    logic sclk_en;
    logic clk_div_en;
    logic spi_counter_en;
    logic word_done;

    // Helper wires for hierarchical references in the existing testbench
    wire [WIDTH-1:0] rx_sipo_out = sipo_data_out;
    wire sipo_load = sipo_shift;
    wire sipo_transfer = rx_fifo_write;
    wire sipo_sclk_en = sclk_en;

    // Output busy assignment
    assign busy = piso_busy | sipo_busy;

    // Module Instantiations
    spi_registers #(
        .WIDTH(WIDTH),
        .SIZE(SIZE)
    ) regs_inst (
        .clk(clk),
        .rst_n(rst_n),
        .data(reg_data),
        .msb(msb),
        .cpol(cpol),
        .cpha(cpha),
        .bits(word_size),
        .div_value(div_value)
    );

    spi_rx_tx_fifo #(
        .FIFO_WIDTH(WIDTH),
        .FIFO_DEPTH(FIFO_DEPTH)
    ) tx_fifo_inst (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(tx_data_in),
        .data_out(tx_fifo_data_out),
        .r_en(tx_fifo_read),
        .w_en(tx_w_en),
        .done(tx_fifo_done_internal),
        .empty(tx_fifo_empty),
        .full(tx_fifo_full)
    );

    spi_rx_tx_fifo #(
        .FIFO_WIDTH(WIDTH),
        .FIFO_DEPTH(FIFO_DEPTH)
    ) rx_fifo_inst (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(sipo_data_out),
        .data_out(rx_data_out),
        .r_en(rx_r_en),
        .w_en(rx_fifo_write),
        .done(rx_fifo_done_internal),
        .empty(rx_fifo_empty),
        .full(rx_fifo_full)
    );

    spi_piso_reg #(
        .WIDTH(WIDTH)
    ) piso_reg_inst (
        .clk(clk),
        .rst_n(rst_n),
        .word_done(word_done),
        .sclk_en(sclk_en),
        .piso_shift(piso_shift),
        .piso_load(piso_load),
        .piso_busy(piso_busy),
        .data_in(tx_fifo_data_out),
        .msb(msb),
        .data_out(mosi)
    );

    spi_sipo_reg #(
        .WIDTH(WIDTH)
    ) sipo_reg_inst (
        .clk(clk),
        .rst_n(rst_n),
        .sipo_shift(sipo_shift),
        .msb(msb),
        .sipo_busy(sipo_busy),
        .word_done(word_done),
        .sclk_en(sclk_en),
        .data_in(miso),
        .data_out(sipo_data_out)
    );

    spi_clk_divider #(
        .WIDTH(WIDTH)
    ) clk_divider_inst (
        .clk(clk),
        .rst_n(rst_n),
        .count(div_value),
        .clk_div_en(clk_div_en),
        .cpol(cpol),
        .sclk(sclk),
        .sclk_en(sclk_en)
    );

    spi_counter #(
        .WIDTH(WIDTH)
    ) counter_inst (
        .clk(clk),
        .sclk_en(sclk_en),
        .rst_n(rst_n),
        .spi_counter_en(spi_counter_en),
        .word_size(word_size),
        .word_done(word_done)
    );

    spi_fsm fsm_inst (
        .clk(clk),
        .rst_n(rst_n),
        .piso_busy(piso_busy),
        .piso_load(piso_load),
        .piso_shift(piso_shift),
        .sipo_busy(sipo_busy),
        .sipo_shift(sipo_shift),
        .tx_fifo_empty(tx_fifo_empty),
        .tx_fifo_read(tx_fifo_read),
        .tx_fifo_write(),
        .tx_fifo_done(tx_fifo_done),
        .rx_fifo_full(rx_fifo_full),
        .rx_fifo_read(),
        .rx_fifo_write(rx_fifo_write),
        .rx_fifo_done(rx_fifo_done),
        .word_done(word_done),
        .spi_counter_en(spi_counter_en),
        .clk_div_en(clk_div_en),
        .CS_n(cs_n)
    );

    spi_interrupts #(
        .IR_SIZE(IR_SIZE)
    ) interrupts_inst (
        .rx_fifo_full(rx_fifo_full),
        .rx_fifo_empty(rx_fifo_empty),
        .tx_fifo_full(tx_fifo_full),
        .tx_fifo_empty(tx_fifo_empty),
        .sipo_busy(sipo_busy),
        .piso_busy(piso_busy),
        .ie(irq_en),
        .irq(irq)
    );

endmodule
