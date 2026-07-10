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

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sclk      <= cpol;
            sclk_en   <= 1'b0;
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

                // Generate sclk_en pulse
                sclk_en <= (count_reg == (count/2) - 1);
            end else begin
                sclk      <= cpol;
                sclk_en   <= 1'b0;
                count_reg <= '0;
            end
        end
    end

endmodule
