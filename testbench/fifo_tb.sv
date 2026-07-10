`timescale 1ns/1ps

module fifo_tb;

parameter FIFO_WIDTH = 8;
parameter FIFO_DEPTH = 8;


logic clk;
logic rst_n;
logic [FIFO_WIDTH-1:0] data_in;
logic [FIFO_WIDTH-1:0] data_out;
logic r_en;
logic w_en;
logic done;
logic empty;
logic full;

spi_rx_tx_fifo #(
    .FIFO_WIDTH(FIFO_WIDTH),
    .FIFO_DEPTH(FIFO_DEPTH)
) dut (
    .clk(clk),
    .rst_n(rst_n),

    .data_in(data_in),
    .data_out(data_out),

    .r_en(r_en),
    .w_en(w_en),

    .done(done),
    .empty(empty),

    .full(full)
);

always #5 clk = ~clk;

task wr_byte(input logic [FIFO_WIDTH-1:0] data);
begin 
    
    data_in <= data;
    w_en <= 1;
    #10;
end
endtask

initial begin 
    clk = 0;
    rst_n = 0;
    data_in = 0;
    r_en = 0;
    w_en = 0;
    #13;
    rst_n <= 1;

    wr_byte(64);
    wr_byte(65);
    wr_byte(66);
    wr_byte(67);
    wr_byte(68);
    wr_byte(64);
    wr_byte(65);
    wr_byte(66);
    wr_byte(67);
    wr_byte(68);
    w_en <= 0;
    r_en <= 1;
    repeat(10) @(posedge clk);
    r_en <= 0;
    wr_byte(67);
    wr_byte(67);
    wr_byte(67);
    wr_byte(67);
    wr_byte(67);
    wr_byte(67);
    wr_byte(67);
    wr_byte(67);
    wr_byte(67);
    wr_byte(67);
    
    #100;
    $finish;
end
initial begin 
    $dumpfile("output/fifo_tb.vcd");
    $dumpvars(0,fifo_tb);
    $monitor("Time=%0d clk=%b rst_n=%b w_en=%b w_ptr=%d w_addr=%d data_in=%d full=%b empty=%b mem=[%d,%d,%d,%d,%d,%d,%d,%d] data_out=%d done=%b",
             $time, clk, rst_n, w_en, dut.w_ptr, dut.w_addr, data_in, full, empty, dut.mem[0], dut.mem[1], dut.mem[2], dut.mem[3], dut.mem[4], dut.mem[5], dut.mem[6], dut.mem[7], data_out, done);
end

endmodule
