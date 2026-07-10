module spi_registers #(
    parameter WIDTH = 8,
    parameter SIZE = 16
)(  
    input logic clk,
    input logic rst_n,  

    input logic [2*SIZE-1:0] data,
    
    output logic msb,
    output logic cpol,
    output logic cpha,
    output logic [WIDTH-1:0] bits,
    output logic [WIDTH-1:0] div_value
);
    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n)begin 
            cpol <= 0;
            cpha <= 0;
        end
        cpol <= data[0];
        cpha <= data[1];
        msb <= data[2];
        bits <= data[10:3];
        div_value <= data[18:11];
        
    end

endmodule
