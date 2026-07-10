module spi_interrupts#(
    parameter IR_SIZE = 8
) (
    input logic rx_fifo_full,
    input logic rx_fifo_empty,

    input logic tx_fifo_full,
    input logic tx_fifo_empty,

    input logic sipo_busy,
    input logic piso_busy,

    input logic [IR_SIZE-1:0] ie, //interrupt enable
    
    output logic irq 

);
    logic [IR_SIZE-1:0] ir_status_reg;

    always_comb begin

        ir_status_reg[0] = rx_fifo_full ;//bit 0
        ir_status_reg[1] = rx_fifo_empty ; //bit 1

        ir_status_reg[2] = tx_fifo_full ; // bit 2
        ir_status_reg[3] = tx_fifo_empty ; // bit 3

        ir_status_reg[4] = sipo_busy ; // bit 4
        ir_status_reg[5] = piso_busy ; // bit 5

        irq =|(ie & ir_status_reg);

    end
endmodule
