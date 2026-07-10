module spi_piso_reg #(
    parameter WIDTH = 8
)(
    input logic clk,
    input logic rst_n,

    input logic word_done,
    input logic sclk_en,

    input logic piso_shift,
    input logic piso_load,

    output logic piso_busy,
    
    input logic [WIDTH-1:0] data_in,
    input logic msb,

    output logic data_out
);
    
    reg [WIDTH-1:0] piso_reg;
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            piso_reg  <= '0;
            data_out  <= '0;
            piso_busy <= 0;
        end
        else begin 
            if(piso_load) begin 
                piso_reg <= data_in;
                data_out <= msb ? data_in[WIDTH-1] : data_in[0];
                piso_busy <= 1;
            end
            else if(word_done) begin 
                piso_busy <= 0;
            end
            else if (sclk_en && piso_shift) begin 
                if(msb) begin 
                    piso_reg <= {piso_reg[WIDTH-2:0], 1'b0};
                    data_out <= piso_reg[WIDTH-2];
                end
                else begin
                    piso_reg <= {1'b0, piso_reg[WIDTH-1:1]};
                    data_out <= piso_reg[1]; 
                end
                piso_busy <= 1;
            end
        end
    end

endmodule
