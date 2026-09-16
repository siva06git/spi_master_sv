`timescale 1ps/1ps

module spi_registers_tb;

logic clk;
logic rst_n;

logic [4*WIDTH-1:0]data;

logic msb;
logic cpol;
logic cpha;
logic [WIDTH-1:0]bits;
logic [WIDTH-1:0]div_value;

parameter WIDTH = 8;

    spi_registers #(
        .WIDTH(WIDTH)
    )dut(
        .clk(clk),
        .rst_n(rst_n),

        .data(data),

        .msb(msb),
        .cpol(cpol),
        .cpha(cpha),
        .bits(bits),
        .div_value(div_value)
    );

always #5 clk <= ~clk;

logic [4*WIDTH-1:0] stimulus;

logic expected_cpol;
logic expected_cpha;
logic expected_msb;
logic [WIDTH-1:0] expected_bits;
logic [WIDTH-1:0] expected_div_value;

logic unused;



task driver(input logic [4*WIDTH-1:0] test_data);
    
    data = test_data;
    @(posedge clk);
    #1;
endtask

task scoreboard(input logic [4*WIDTH-1:0] test_data);
    unused = ^test_data[31:19];

    expected_cpol      = test_data[0];
    expected_cpha      = test_data[1];
    expected_msb       = test_data[2];
    expected_bits      = test_data[3 +: WIDTH];
    expected_div_value = test_data[11 +: WIDTH];
endtask

task compare_res();
    if (expected_cpol !== cpol)
        $error("CPOL mismatch");

    if (expected_cpha !== cpha)
        $error("CPHA mismatch");

    if (expected_msb !== msb)
        $error("MSB mismatch");

    if (expected_bits !== bits)
        $error("BITS mismatch");

    if (expected_div_value !== div_value)
        $error("DIV_VALUE mismatch");
endtask

initial begin
    rst_n = 0;
    #2;

    stimulus = 'b0;
    stimulus[0]            = 1'b1;       // CPOL
    stimulus[1]            = 1'b0;       // CPHA
    stimulus[2]            = 1'b1;       // MSB
    stimulus[3 +: WIDTH]   = 8'd8;        // bits
    stimulus[11 +: WIDTH]  = 8'd20;       // div_value

    scoreboard(stimulus);
    driver(stimulus);
    compare_res();

    $display("No errors");
    #100;
    $finish;

end
initial begin
    $dumpfile("output/spi_registers.vcd");
    $dumpvars(0, spi_registers_tb);
end

endmodule
