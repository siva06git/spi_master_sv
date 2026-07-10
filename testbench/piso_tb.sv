`timescale 1ns/1ps

module piso_tb;

    parameter WIDTH = 8;

    logic clk;
    logic rst_n;
    
    logic word_done;
    logic sclk_en;

    logic piso_load;
    logic piso_shift;

    logic piso_busy;

    logic [7:0] data_in;
    logic msb;

    logic data_out;

    spi_piso_reg #(
        .WIDTH(WIDTH)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),

        .word_done(word_done),
        .sclk_en(sclk_en),
        .piso_load(piso_load),
        .piso_shift(piso_shift),

        .piso_busy(piso_busy),
        .data_in(data_in),

        .msb(msb),
        .data_out(data_out)
    );

    always #5 clk = ~clk;

    task load_data(input logic [WIDTH-1:0] data);
    begin 
        data_in = data;
    end
    endtask

    task generate_pulse;
    begin 
        @(posedge clk)
        sclk_en = 1;
        @(posedge clk)
        sclk_en = 0; 
    end 
    endtask

    initial begin
        clk = 0;
        rst_n = 0;
        word_done = 0;
        sclk_en = 0;
        piso_shift = 0;
        piso_load = 0;
        
        data_in = 0;
        msb = 0;

        #20;
        rst_n = 1;

        piso_load = 1;
        load_data(8'b11111111);
        #50;
        piso_load = 0;
        piso_shift = 1;
        msb = 1;
        for(integer i = 0;i<8;i = i+1)begin
            generate_pulse(); 
        end
        word_done = 1;
        piso_shift = 0;
        #50;
        $finish;
    end

    initial begin
        $monitor("T=%0d data_in=%b sclk_en=%b busy=%b data_out=%b", $time,
                                                                    piso_shift,
                                                                    sclk_en,
                                                                    piso_busy,
                                                                    data_out);
    end

    initial begin 
        $dumpfile("piso_tb.vcd");
        $dumpvars(0,piso_tb);
    end


endmodule
