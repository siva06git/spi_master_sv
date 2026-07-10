module spi_sipo_reg #(
    parameter WIDTH = 8
)(
    input logic clk,
    input logic rst_n,
    
    input logic sipo_shift,
    input logic msb,
    output logic sipo_busy,

    input logic word_done,
    input logic sclk_en,
    input logic data_in,
    output logic [WIDTH-1:0] data_out
);

    logic [WIDTH-1:0] data;
    assign data_out = data;
    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin 
            data      <= '0;
            sipo_busy <= 1'b0;
        end
        else begin 
            if(word_done) begin
                sipo_busy <= 1'b0;
            end
            else if(sipo_shift) begin
                sipo_busy <= 1'b1;
            end

            if(sclk_en && sipo_shift) begin 
                if(msb) begin
                    data <= {data[WIDTH-2:0], data_in};
                end
                else begin 
                    data <= {data_in, data[WIDTH-1:1]};
                end
            end        
        end 
    end

endmodule
