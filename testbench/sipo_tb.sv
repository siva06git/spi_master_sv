`timescale 1ns/1ps

module sipo_tb;

    parameter WIDTH = 8;

    logic clk;
    logic rst_n;

    logic sipo_shift;
    logic msb;
    logic sipo_busy;

    logic word_done;
    logic sclk_en;
    logic data_in;
    logic [WIDTH-1:0] data_out;

    spi_sipo_reg #(
        .WIDTH(WIDTH)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),

        .sipo_busy(sipo_busy),
        .sipo_shift(sipo_shift),
        .msb(msb),

        .word_done(word_done),
        .sclk_en(sclk_en),
        .data_in(data_in),
        .data_out(data_out)
    );

    //-------------------------
    // Clock
    //-------------------------
    always #5 clk = ~clk;

    //-------------------------
    // Generate one sclk_en pulse
    //-------------------------
    task pulse_sclk;
    begin
        @(posedge clk);
        sclk_en = 1;
        @(posedge clk);
        sclk_en = 0;
    end
    endtask

    //-------------------------
    // Send one bit
    //-------------------------
    task send_bit(input logic bit_val);
    begin
        data_in = bit_val;
        pulse_sclk();
    end
    endtask

    task send_byte(input logic [7:0] data, input logic msb_first);
    integer i;
    begin
        if (msb_first) begin
            for (i = 7; i >= 0; i--) begin
                data_in = data[i];
                if (i == 0) word_done = 1;
                pulse_sclk();
                word_done = 0;
            end
        end else begin
            for (i = 0; i < 8; i++) begin
                data_in = data[i];
                if (i == 7) word_done = 1;
                pulse_sclk();
                word_done = 0;
            end
        end
    end
    endtask

    //-------------------------
    // Stimulus
    //-------------------------
    initial begin

        clk           = 0;
        rst_n         = 0;
        sipo_shift     = 0;
        msb           = 1;
        word_done     = 0;
        sclk_en       = 0;
        data_in       = 0;

        //---------------------
        // Reset
        //---------------------
        #20;
        rst_n = 1;

        // Test 1: MSB First
        msb = 1;
        sipo_shift = 1;
        // Send 10110010 in MSB-first order
        send_byte(8'b10110010, 1);
        sipo_shift = 0;

        #20;

        // Reset between tests to clear shift register state
        rst_n = 0;
        #20;
        rst_n = 1;
        #20;

        // Test 2: LSB First
        msb = 0;
        sipo_shift = 1;
        // Send 10110010 in LSB-first order
        send_byte(8'b10110010, 0);
        sipo_shift = 0;

        #50;
        $finish;

    end

    //-------------------------
    // Monitor
    //-------------------------
    initial begin
        $monitor("T=%0t data_in=%b sclk_en=%b busy=%b data_out=%b",
                 $time,
                 data_in,
                 sclk_en,
                 sipo_busy,
                 data_out);
    end

    initial begin
        $dumpfile("sipo_tb.vcd");
        $dumpvars(0, sipo_tb);
    end

endmodule