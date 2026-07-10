module spi_rx_tx_fifo #(
    parameter FIFO_WIDTH = 8,
    parameter FIFO_DEPTH = 8
)(
    input logic clk,
    input logic rst_n,

    input logic [FIFO_WIDTH-1:0] data_in,
    output logic [FIFO_WIDTH-1:0] data_out,

    input logic r_en,
    input logic w_en,

    output logic done,
    output logic empty,
    output logic full
);
    localparam PTR_SIZE = $clog2(FIFO_DEPTH);

    logic [FIFO_WIDTH-1:0] mem [FIFO_DEPTH-1:0];

    reg [PTR_SIZE:0] r_ptr;
    reg [PTR_SIZE:0] w_ptr;

    reg [PTR_SIZE-1:0] r_addr;
    reg [PTR_SIZE-1:0] w_addr;

    assign r_addr = r_ptr[PTR_SIZE-1:0];
    assign w_addr = w_ptr[PTR_SIZE-1:0];

    assign empty = (r_ptr == w_ptr);
    assign full = (r_addr == w_addr) && (r_ptr[PTR_SIZE] != w_ptr[PTR_SIZE]);

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin 
            data_out <= '0;
            r_ptr <= '0;
            w_ptr <= '0;
            done <= '0;
        end
        else begin 
            if(!empty && r_en) begin 
                r_ptr <= r_ptr + 1;
                data_out <= mem[r_addr];
                done <= 1;
            end
            else begin
                done <= 0;
            end
            if(!full && w_en) begin
                w_ptr <= w_ptr + 1;
                mem[w_addr] <= data_in;
            end 
        end
    end

endmodule
