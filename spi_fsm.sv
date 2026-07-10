module spi_fsm(
    input logic clk,
    input logic rst_n,

    // PISO shift register signals
    input logic piso_busy,
    output logic piso_load,
    output logic piso_shift,
    
    // SIPO shift register signals 
    input logic sipo_busy,
    output logic sipo_shift,

    // Transmit FIFO (tx_fifo in standard naming)
    input logic tx_fifo_empty,
    output logic tx_fifo_read,
    output logic tx_fifo_write,
    output logic tx_fifo_done,

    // Receive FIFO (rx_fifo in standard naming)
    input logic rx_fifo_full,
    output logic rx_fifo_read,
    output logic rx_fifo_write,
    output logic rx_fifo_done,
    
    // Counter signals
    input logic word_done,
    output logic spi_counter_en,
    
    // Clock Divider controls
    output logic clk_div_en,
    output logic CS_n
);

    // Corrected state enum declaration (2-bit base type, assignment syntax, comma separators)
    typedef enum logic [2:0] {  
        IDLE     = 3'b000,
        LOAD     = 3'b001,
        WAIT     = 3'b010,
        TRANSFER = 3'b011,
        DONE     = 3'b100
    } spi_state_t;

    spi_state_t state, next_state;

    // Sequential block with asynchronous active-low reset
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
        end else begin 
            state <= next_state;
        end
    end

    // Combinational block
    always_comb begin 
        // Default next_state assignment prevents latch generation
        next_state = state;

        // Default output values to prevent latching on outputs
        CS_n = 1'b1;
        rx_fifo_read = 1'b0;
        rx_fifo_write = 1'b0;
        rx_fifo_done = 1'b0;

        tx_fifo_read = 1'b0;
        tx_fifo_write = 1'b0;
        tx_fifo_done = 1'b0;
        
        sipo_shift = 1'b0;
        
        piso_load = 1'b0;
        piso_shift = 1'b0;

        clk_div_en = 1'b0;
        spi_counter_en = 1'b0;

        case (state)
            IDLE : begin 
                CS_n = 1'b1;
                if (!tx_fifo_empty && !piso_busy) begin
                    next_state = LOAD;
                end
            end

            LOAD : begin 
                CS_n = 1'b1;
                // Pop data from transmit FIFO (tx_fifo)
                tx_fifo_read = 1'b1;
                // Assert load to PISO shift register
                piso_load = 1'b1;
                
                // Transition to TRANSFER next cycle once load is complete
                next_state = WAIT;
            end

            WAIT : begin 
                CS_n = 1'b1;
                piso_load = 1'b1;
                next_state = TRANSFER;
            
            end


            TRANSFER : begin 
                CS_n = 1'b0;
                clk_div_en = 1'b1;
                spi_counter_en = 1'b1;

                // Enable shifting in PISO and SIPO registers
                piso_shift = 1'b1;
                sipo_shift = 1'b1; // In your spi_sipo_reg, sipo_shift performs shift-in

                // Transition to DONE when the bit counter asserts word_done
                if (word_done) begin 
                    next_state = DONE;
                end
            end

            DONE : begin 
                CS_n = 1'b1;
                // Tell SIPO to output its parallel data to rx_fifo


                // Push received parallel data to the receive FIFO (rx_fifo)
                if (!rx_fifo_full && !sipo_busy) begin
                    rx_fifo_write = 1'b1;
                end

                // Transition back to IDLE unconditionally after processing
                next_state = IDLE;
                
                // Assert FSM transaction/write complete pulse
                rx_fifo_done = 1'b1;
                tx_fifo_done = 1'b1;
            end

            default: next_state = IDLE;
        endcase
    end

endmodule
