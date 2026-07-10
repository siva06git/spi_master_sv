`timescale 1ns/1ps

module clk_divider_tb;

    parameter WIDTH = 8;

    logic clk;
    logic rst_n;
    logic [WIDTH-1:0] count;
    logic clk_div_en;
    logic cpol;
    logic sclk;
    logic sclk_en;

    // Instantiate UUT
    spi_clk_divider #(
        .WIDTH(WIDTH)
    ) uut (
        .clk(clk),
        .rst_n(rst_n),
        .count(count),
        .clk_div_en(clk_div_en),
        .cpol(cpol),
        .sclk(sclk),
        .sclk_en(sclk_en)
    );

    // Clock Generator (100 MHz -> 10ns period)
    always #5 clk = ~clk;

    // Helper task to measure clock properties
    // Measures the period of sclk, its high time, low time, and number of sclk_en pulses
    task verify_divider(
        input int expected_div,
        input logic expected_cpol
    );
        time start_time;
        time high_time;
        time low_time;
        time total_period;
        int sclk_en_count;

        begin
            $display("--- Verifying Divider count=%0d, CPOL=%b ---", expected_div, expected_cpol);
            
            // Wait for clk_div_en to be active and align with clk edge
            @(posedge clk);
            
            // Let the divider run for a bit to stabilize
            repeat(expected_div * 2) @(posedge clk);
            
            // 1. Wait for sclk to be in its idle state (expected_cpol)
            while (sclk !== expected_cpol) @(posedge clk);
            // 2. Wait for sclk to transition to its active state (~cpol)
            while (sclk === expected_cpol) @(posedge clk);
            start_time = $time;
            sclk_en_count = 0;
            
            // 2. Measure active phase duration (~cpol)
            while (sclk === ~expected_cpol) begin
                if (sclk_en) sclk_en_count++;
                @(posedge clk);
            end
            high_time = $time - start_time;
            
            // 3. Measure idle phase duration (cpol)
            start_time = $time;
            while (sclk === expected_cpol) begin
                if (sclk_en) sclk_en_count++;
                @(posedge clk);
            end
            low_time = $time - start_time;
            
            total_period = high_time + low_time;
            
            // Report findings
            $display("Measured sclk high time   = %0t ns", high_time);
            $display("Measured sclk low time    = %0t ns", low_time);
            $display("Measured sclk period      = %0t ns (Expected %0d ns)", total_period, expected_div * 10);
            $display("Number of sclk_en pulses  = %0d (Expected 1)", sclk_en_count);
            
            if (total_period !== expected_div * 10) begin
                $display("ERROR: Division ratio mismatch!");
            end else if (sclk_en_count !== 1) begin
                $display("ERROR: sclk_en count mismatch!");
            end else begin
                $display("SUCCESS: Division by %0d verified successfully.", expected_div);
            end
        end
    endtask

    initial begin
        clk = 0;
        rst_n = 0;
        count = 4;
        clk_div_en = 0;
        cpol = 0;
        
        #20;
        rst_n = 1;
        #10;

        //---------------------------------------------------------
        // Test Case 1: Division by 4 (Even)
        //---------------------------------------------------------
        count = 4;
        cpol = 0;
        clk_div_en = 1;
        verify_divider(4, 0);
        clk_div_en = 0;
        #50;

        //---------------------------------------------------------
        // Test Case 2: Division by 5 (Odd)
        //---------------------------------------------------------
        count = 5;
        cpol = 0;
        clk_div_en = 1;
        verify_divider(5, 0);
        clk_div_en = 0;
        #50;

        //---------------------------------------------------------
        // Test Case 3: Division by 3 (Odd)
        //---------------------------------------------------------
        count = 3;
        cpol = 0;
        clk_div_en = 1;
        verify_divider(3, 0);
        clk_div_en = 0;
        #50;

        //---------------------------------------------------------
        // Test Case 4: Division by 8 with CPOL = 1
        //---------------------------------------------------------
        count = 8;
        cpol = 1;
        clk_div_en = 1;
        verify_divider(8, 1);
        clk_div_en = 0;
        #50;

        $display("Clock Divider Testbench Completed.");
        $finish;
    end

    initial begin
        $dumpfile("output/clk_divider_tb.vcd");
        $dumpvars(0, clk_divider_tb);
        $monitor("t=%0d | clk=%b | clk_div_en=%b | count=%d | count_reg=%d | sclk=%b | sclk_en=%b", 
                 $time, clk, clk_div_en, count, uut.count_reg, sclk, sclk_en);
    end

endmodule
