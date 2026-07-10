`timescale 1ns/1ps

module fsm_tb;

    logic clk;
    logic rst_n;

    // PISO shift register signals
    logic piso_busy;
    logic piso_load;
    logic piso_shift;
    
    // SIPO shift register signals 
    logic sipo_busy;
    logic sipo_shift;

    // Transmit FIFO (tx_fifo in standard naming)
    logic tx_fifo_empty;
    logic tx_fifo_read;
    logic tx_fifo_write;
    logic tx_fifo_done;

    // Receive FIFO (rx_fifo in standard naming)
    logic rx_fifo_full;
    logic rx_fifo_read;
    logic rx_fifo_write;
    logic rx_fifo_done;
    
    // Counter signals
    logic word_done;
    logic spi_counter_en;
    
    // Clock Divider controls
    logic clk_div_en;
    logic CS_n;

    // Instantiate UUT (spi_fsm)
    spi_fsm dut (
        .clk(clk),
        .rst_n(rst_n),

        // PISO shift register signals
        .piso_busy(piso_busy),
        .piso_load(piso_load),
        .piso_shift(piso_shift),
        
        // SIPO shift register signals 
        .sipo_busy(sipo_busy),
        .sipo_shift(sipo_shift),

        // Transmit FIFO (tx_fifo in standard naming)
        .tx_fifo_empty(tx_fifo_empty),
        .tx_fifo_read(tx_fifo_read),
        .tx_fifo_write(tx_fifo_write),
        .tx_fifo_done(tx_fifo_done),

        // Receive FIFO (rx_fifo in standard naming)
        .rx_fifo_full(rx_fifo_full),
        .rx_fifo_read(rx_fifo_read),
        .rx_fifo_write(rx_fifo_write),
        .rx_fifo_done(rx_fifo_done),
        
        // Counter signals
        .word_done(word_done),
        .spi_counter_en(spi_counter_en),
        
        // Clock Divider controls
        .clk_div_en(clk_div_en),
        .CS_n(CS_n)
    );

    // Clock Generator
    always #5 clk = ~clk;

    initial begin
        // Initialize Signals
        clk = 0;
        rst_n = 0;
        piso_busy = 0;
        sipo_busy = 0;
        tx_fifo_empty = 1;
        rx_fifo_full = 0;
        word_done = 0;

        // Reset Pulse
        #20;
        rst_n <= 1;
        #10;

        //---------------------------------------------------------
        // Test Case 1: Idle state when transmit FIFO is empty
        //---------------------------------------------------------
        $display("[TC1] Verifying IDLE state...");
        @(posedge clk);
        if (dut.state !== dut.IDLE) begin
            $display("ERROR: FSM should be in IDLE state");
        end

        //---------------------------------------------------------
        // Test Case 2: Transition to LOAD and then TRANSFER
        //---------------------------------------------------------
        $display("[TC2] Initiating transaction (FIFO not empty)...");
        @(negedge clk);
        tx_fifo_empty <= 0; // Data available to transmit

        // Next edge should transition to LOAD
        @(posedge clk);
        #1; // Wait for state transition to settle
        if (dut.state !== dut.LOAD) begin
            $display("ERROR: FSM failed to transition to LOAD");
        end
        if (tx_fifo_read !== 1 || piso_load !== 1 || CS_n !== 1) begin
            $display("ERROR: LOAD control signals incorrect");
        end

        // Next edge should transition to TRANSFER
        @(posedge clk);
        #1;
        if (dut.state !== dut.TRANSFER) begin
            $display("ERROR: FSM failed to transition to TRANSFER");
        end
        if (CS_n !== 0 || clk_div_en !== 1 || spi_counter_en !== 1 || piso_shift !== 1 || sipo_shift !== 1) begin
            $display("ERROR: TRANSFER control signals incorrect");
        end

        // Stay in TRANSFER for a few cycles
        repeat (3) @(posedge clk);
        #1;
        if (dut.state !== dut.TRANSFER) begin
            $display("ERROR: FSM left TRANSFER state prematurely");
        end

        //---------------------------------------------------------
        // Test Case 3: Transition from TRANSFER to DONE
        //---------------------------------------------------------
        $display("[TC3] Transitioning to DONE state...");
        @(negedge clk);
        word_done <= 1;

        @(posedge clk);
        #1;
        if (dut.state !== dut.DONE) begin
            $display("ERROR: FSM failed to transition to DONE");
        end
        if (CS_n !== 1 || rx_fifo_write !== 1 || rx_fifo_done !== 1 || tx_fifo_done !== 1) begin
            $display("ERROR: DONE control signals incorrect");
        end

        // Next edge should return to IDLE
        @(posedge clk);
        #1;
        if (dut.state !== dut.IDLE) begin
            $display("ERROR: FSM failed to return to IDLE");
        end

        //---------------------------------------------------------
        // Test Case 4: DONE state when RX FIFO is full
        //---------------------------------------------------------
        $display("[TC4] Testing DONE state with RX FIFO full...");
        @(negedge clk);
        tx_fifo_empty <= 0;
        word_done <= 0;
        rx_fifo_full <= 1;

        // Move through LOAD -> TRANSFER
        @(posedge clk); // to LOAD
        @(posedge clk); // to TRANSFER
        #1;
        if (dut.state !== dut.TRANSFER) begin
            $display("ERROR: FSM failed to reach TRANSFER in TC4");
        end

        @(negedge clk);
        word_done <= 1;

        @(posedge clk); // to DONE
        #1;
        if (dut.state !== dut.DONE) begin
            $display("ERROR: FSM failed to reach DONE in TC4");
        end
        // With rx_fifo_full = 1, rx_fifo_write must be 0
        if (rx_fifo_write !== 0) begin
            $display("ERROR: rx_fifo_write asserted when RX FIFO is full!");
        end

        @(posedge clk); // back to IDLE
        #1;
        $display("FSM Testbench Completed.");
        $finish;
    end

    // Waveform Dump
    initial begin
        $dumpfile("output/fsm_tb.vcd");
        $dumpvars(0, fsm_tb);
    end

endmodule
