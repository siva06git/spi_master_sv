`timescale 1ns/1ps

module spi_top_verify_tb;

    parameter WIDTH = 8;
    parameter SIZE = 16;
    parameter FIFO_DEPTH = 8;
    parameter IR_SIZE = 8;

    logic clk;
    logic rst_n;

    // External SPI Pins
    logic sclk;
    logic mosi;
    logic miso;
    logic cs_n;

    // Host Buffer Interface
    logic [2*SIZE-1:0] reg_data;
    logic [WIDTH-1:0] tx_data_in;
    logic tx_w_en;
    logic tx_fifo_full;
    logic tx_fifo_empty;
    logic tx_fifo_done;

    logic [WIDTH-1:0] rx_data_out;
    logic rx_r_en;
    logic rx_fifo_full;
    logic rx_fifo_empty;
    logic rx_fifo_done;

    // Interrupt Controls & Output
    logic [IR_SIZE-1:0] irq_en;
    logic irq;
    logic busy;

    // Instantiate UUT
    spi_top #(
        .WIDTH(WIDTH),
        .SIZE(SIZE),
        .FIFO_DEPTH(FIFO_DEPTH),
        .IR_SIZE(IR_SIZE)
    ) uut (
        .clk(clk),
        .rst_n(rst_n),
        .sclk(sclk),
        .mosi(mosi),
        .miso(miso),
        .cs_n(cs_n),
        .reg_data(reg_data),
        .tx_data_in(tx_data_in),
        .tx_w_en(tx_w_en),
        .tx_fifo_full(tx_fifo_full),
        .tx_fifo_empty(tx_fifo_empty),
        .tx_fifo_done(tx_fifo_done),
        .rx_data_out(rx_data_out),
        .rx_r_en(rx_r_en),
        .rx_fifo_full(rx_fifo_full),
        .rx_fifo_empty(rx_fifo_empty),
        .rx_fifo_done(rx_fifo_done),
        .irq_en(irq_en),
        .irq(irq),
        .busy(busy)
    );

    // Clock generator (100 MHz clock -> 10ns period)
    always #5 clk = ~clk;

    // Connect MISO to MOSI for a basic loopback verification
    assign miso = mosi;

    initial begin
        // Initialize Signals
        clk = 0;
        rst_n = 0;
        reg_data = '0;
        tx_data_in = '0;
        tx_w_en = 0;
        rx_r_en = 0;
        irq_en = '0;

        // Reset Pulse
        #20;
        rst_n = 1;
        #20;

        // Configure Registers:
        // bits 0-1   : CPOL = 0, CPHA = 0
        // bits 9-2   : word_size = 8
        // bits 17-10 : div_value = 4
        reg_data = {13'd0, 8'd4, 8'd8, 1'b0, 1'b0, 1'b0};
        #20;

        // Write transmit byte 8'hA5 into TX FIFO
        @(posedge clk)
        tx_data_in = 8'hA5;
        tx_w_en = 1'b1;
    
        @(posedge clk);
        tx_w_en = 1'b0;

        // Wait for the transfer to complete
        #1000;

        // Read received data from RX FIFO
        @(posedge clk);
        rx_r_en = 1'b1;
        @(posedge clk);
        rx_r_en = 1'b0;
        
        #10;
        $display("----------------------------------------------");
        $display("Verification Check:");
        $display("TX Data Written: 8'hA5");
        $display("RX Data Read   : 8'h%h", rx_data_out);
        if (rx_data_out === 8'hA5) begin
            $display("SUCCESS: RX Data matches TX Data!");
        end else begin
            $display("ERROR: RX Data mismatch!");
        end
        $display("----------------------------------------------");

        // End Simulation
        $finish;
    end

    // Dump waveforms
    initial begin
        $dumpfile("output/spi_top_verify_tb.vcd");
        $dumpvars(0, spi_top_verify_tb);
    end

    // Monitor transitions
    initial begin
        $monitor("t=%0t | cs_n=%b | sclk=%b | mosi=%b | miso=%b | piso_reg=%b | sipo_data=%b | sipo_out=%b | sipo_ld=%b | sipo_tf=%b | sipo_se=%b | rx_empty=%b | rx_out=%h", 
                 $time, cs_n, sclk, mosi, miso, uut.piso_reg_inst.piso_reg, uut.sipo_reg_inst.data, uut.rx_sipo_out, uut.sipo_load, uut.sipo_transfer, uut.sipo_sclk_en, rx_fifo_empty, rx_data_out);
    end

endmodule
