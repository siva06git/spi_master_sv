`timescale 1ps/1ps
module spi_clk_divider #(
    parameter WIDTH = 8
)(
    input logic clk,
    input logic rst_n,

    input logic [WIDTH-1:0] count,
    input logic clk_div_en,

    input logic cpol,
    output logic sclk,
    output logic sclk_en
);

    logic [WIDTH-1:0] count_reg;
    logic sclk_pulse;
    logic sclk_d;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sclk      <= cpol;
            count_reg <= '0;
        end else begin
            if (clk_div_en) begin
                // Update counter
                if (count_reg == count - 1) begin
                    count_reg <= '0;
                end else begin
                    count_reg <= count_reg + 1;
                end

                // Generate sclk output
                if (count_reg < count/2) begin
                    sclk <= cpol;
                end else begin
                    sclk <= ~cpol;
                end
            end else begin
                sclk      <= cpol;
                count_reg <= '0;
            end
        end
    end

assign sclk_1 = sclk;

always_ff@(posedge clk) begin 
    if(!rst_n) begin 
        sclk_d <= 0;
        sclk_en <= 0;
    end
    sclk_en  <= sclk & ~sclk_d;
    sclk_d <= sclk; 
end
    

endmodule
