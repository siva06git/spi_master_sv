module spi_counter #(
    parameter WIDTH = 8
)(  
    input logic clk,
    input logic sclk_en,
    input logic rst_n,

    input logic spi_counter_en,
    input logic [WIDTH-1:0] word_size,
    output logic word_done

);

logic [WIDTH-1 : 0] count = '0;

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n)begin 
            count <= '0;
            word_done <= '0;
        end
        else if(spi_counter_en) begin 
            if(sclk_en) begin
                if(count == word_size-1)begin
                    count <= '0;
                    word_done <= '1;
                end
                count <= count+1;
            end
        end
    end


endmodule
