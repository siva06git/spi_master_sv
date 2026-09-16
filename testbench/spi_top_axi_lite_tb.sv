`timescale 1ns/1ps

module spi_top_axi_lite_tb;

    parameter AXI_DATA_WIDTH = 32;
    parameter AXI_ADDR_WIDTH = 5;
    parameter WIDTH              = 8;
    parameter SIZE               = 16;
    parameter FIFO_DEPTH         = 8;
    parameter IR_SIZE            = 8;

    // External SPI Pins
    logic                          sclk;
    logic                          mosi;
    logic                          miso;
    logic                          cs_n;
    logic                          irq;



    interface axi_lite_if #(
        parameter AXI_DATA_WIDTH = 32,
        parameter AXI_ADDR_WIDTH = 5
    )( input logic clk);
        logic                     aresetn;

        logic [AXI_ADDR_WIDTH-1:0] awaddr;
        logic [2:0]                awprot;
        logic                      awvalid;
        logic                      awready;

        logic [AXI_DATA_WIDTH-1:0] wdata;
        logic [(AXI_DATA_WIDTH/8)-1:0] wstrb;
        logic                     wvalid;
        logic                     wready;

        logic [1:0]                bresp;
        logic                     bvalid;
        logic                     bready;

        logic [AXI_ADDR_WIDTH-1:0] araddr;
        logic [2:0]                arprot;
        logic                     arvalid;
        logic                     arready;

        logic [AXI_DATA_WIDTH-1:0] rdata;
        logic [1:0]                rresp;
        logic                     rvalid;
        logic                     rready;

    endinterface

    axi_lite_if #(
        .AXI_DATA_WIDTH(AXI_DATA_WIDTH),
        .AXI_ADDR_WIDTH(AXI_ADDR_WIDTH)
    ) axi_if (
        .clk(s_axi_aclk)
    );



    spi_top_axi_lite #(
        .AXI_DATA_WIDTH(AXI_DATA_WIDTH),
        .AXI_ADDR_WIDTH(AXI_ADDR_WIDTH),
        .WIDTH(WIDTH),
        .SIZE(SIZE),
        .FIFO_DEPTH(FIFO_DEPTH),
        .IR_SIZE(IR_SIZE)
    ) uut (
        .s_axi_aclk    (s_axi_aclk),
        .s_axi_aresetn (axi_if.aresetn),

        // Write Address
        .s_axi_awaddr  (axi_if.awaddr),
        .s_axi_awprot  (axi_if.awprot),
        .s_axi_awvalid (axi_if.awvalid),
        .s_axi_awready (axi_if.awready),

        // Write Data
        .s_axi_wdata   (axi_if.wdata),
        .s_axi_wstrb   (axi_if.wstrb),
        .s_axi_wvalid  (axi_if.wvalid),
        .s_axi_wready  (axi_if.wready),

        // Write Response
        .s_axi_bresp   (axi_if.bresp),
        .s_axi_bvalid  (axi_if.bvalid),
        .s_axi_bready  (axi_if.bready),

        // Read Address
        .s_axi_araddr  (axi_if.araddr),
        .s_axi_arprot  (axi_if.arprot),
        .s_axi_arvalid (axi_if.arvalid),
        .s_axi_arready (axi_if.arready),

        // Read Data
        .s_axi_rdata   (axi_if.rdata),
        .s_axi_rresp   (axi_if.rresp),
        .s_axi_rvalid  (axi_if.rvalid),
        .s_axi_rready  (axi_if.rready),

        // SPI
        .sclk          (sclk),
        .mosi          (mosi),
        .miso          (miso),
        .cs_n          (cs_n),
        .irq           (irq)
    );

    // 100 MHz clock -> 10ns period
    always #5 s_axi_aclk = ~s_axi_aclk;

    // Loopback MOSI to MISO
    assign miso = mosi;


    class axi_driver;
        //need to access 
        //
    endclass

    task automatic axi_write(input [AXI_ADDR_WIDTH-1:0] addr, input [AXI_DATA_WIDTH-1:0] data);
        begin
            @(posedge s_axi_aclk);
            s_axi_awaddr  <= addr;
            s_axi_awvalid <= 1'b1;
            s_axi_wdata   <= data;
            s_axi_wstrb   <= 4'hF;
            s_axi_wvalid  <= 1'b1;
            s_axi_bready  <= 1'b1;

            fork
                begin
                    wait(s_axi_awready);
                    @(posedge s_axi_aclk);
                    s_axi_awvalid <= 1'b0;
                end
                begin
                    wait(s_axi_wready);
                    @(posedge s_axi_aclk);
                    s_axi_wvalid <= 1'b0;
                end
            join

            wait(s_axi_bvalid);
            @(posedge s_axi_aclk);
            s_axi_bready <= 1'b0;
        end
    endtask

    task automatic axi_read(input [AXI_ADDR_WIDTH-1:0] addr, output [AXI_DATA_WIDTH-1:0] data);
        begin
            @(posedge s_axi_aclk);
            s_axi_araddr  <= addr;
            s_axi_arvalid <= 1'b1;
            s_axi_rready  <= 1'b1;

            wait(s_axi_arready);
            @(posedge s_axi_aclk);
            s_axi_arvalid <= 1'b0;

            wait(s_axi_rvalid);
            data = s_axi_rdata;
            @(posedge s_axi_aclk);
            s_axi_rready <= 1'b0;
        end
    endtask

    // ------------------------------------------------------------------------
    // Simulation Flow
    // ------------------------------------------------------------------------
    logic [31:0] read_val;
    logic [31:0] ctrl_val;

    initial begin
        s_axi_aclk    = 0;
        s_axi_aresetn = 0;
        s_axi_awaddr  = 0;
        s_axi_awprot  = 0;
        s_axi_awvalid = 0;
        s_axi_wdata   = 0;
        s_axi_wstrb   = 0;
        s_axi_wvalid  = 0;
        s_axi_bready  = 0;
        s_axi_araddr  = 0;
        s_axi_arprot  = 0;
        s_axi_arvalid = 0;
        s_axi_rready  = 0;

        // Reset Pulse
        #20;
        s_axi_aresetn = 1;
        #20;
        $display("_____________________");
        $display("Starting verification");
        $display("_____________________");
        

        $finish;
    end

    initial begin
        $dumpfile("output/spi_top_axi_lite_tb.vcd");
        $dumpvars(0, spi_top_axi_lite_tb);
    end

endmodule
