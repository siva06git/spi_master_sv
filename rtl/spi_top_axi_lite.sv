// AXI4-Lite Wrapper for SPI Top Module
// Compliant with standard AXI4-Lite Slave specifications.

`timescale 1ns/1ps

module spi_top_axi_lite #(
    parameter AXI_DATA_WIDTH = 32,
    parameter AXI_ADDR_WIDTH = 5,
    parameter WIDTH              = 8,
    parameter SIZE               = 16,
    parameter FIFO_DEPTH         = 8,
    parameter IR_SIZE            = 8  // Interrupt register size
)(
    // AXI4-Lite Clock and Reset
    input  logic                          s_axi_aclk,
    input  logic                          s_axi_aresetn,

    // Write Address Channel
    input  logic [AXI_ADDR_WIDTH-1:0]     s_axi_awaddr,
    input  logic [2:0]                    s_axi_awprot,
    input  logic                          s_axi_awvalid,
    output logic                          s_axi_awready,

    // Write Data Channel
    input  logic [AXI_DATA_WIDTH-1:0]     s_axi_wdata,
    input  logic [(AXI_DATA_WIDTH/8)-1:0] s_axi_wstrb,
    input  logic                          s_axi_wvalid,
    output logic                          s_axi_wready,

    // Write Response Channel
    output logic [1:0]                    s_axi_bresp,
    output logic                          s_axi_bvalid,
    input  logic                          s_axi_bready,

    // Read Address Channel
    input  logic [AXI_ADDR_WIDTH-1:0]     s_axi_araddr,
    input  logic [2:0]                    s_axi_arprot,
    input  logic                          s_axi_arvalid,
    output logic                          s_axi_arready,

    // Read Data Channel
    output logic [AXI_DATA_WIDTH-1:0] s_axi_rdata,
    output logic [1:0]                    s_axi_rresp,
    output logic                          s_axi_rvalid,
    input  logic                          s_axi_rready,

    // External SPI Interface Pins
    output logic                          sclk,
    output logic                          mosi,
    input  logic                          miso,
    output logic                          cs_n,

    // Interrupt Output Pin
    output logic                          irq
);

    // Internal Registers for Memory Mapping
    logic [2*SIZE-1:0]  reg_data_q;
    logic [IR_SIZE-1:0] irq_en_q;
    logic [WIDTH-1:0]   tx_data_in_q;
    logic               tx_w_en_q;
    logic               rx_r_en_q;

    // SPI Top Output Connections
    logic               tx_fifo_full;
    logic               tx_fifo_empty;
    logic               tx_fifo_done;
    logic [WIDTH-1:0]   rx_data_out;
    logic               rx_fifo_full;
    logic               rx_fifo_empty;
    logic               rx_fifo_done;
    logic               busy;

    // AXI4-Lite Internal Handshake Registers
    logic [AXI_ADDR_WIDTH-1:0]     axi_awaddr;
    logic                          axi_awready;
    logic                          axi_wready;
    logic [1:0]                    axi_bresp;
    logic                          axi_bvalid;
    logic [AXI_ADDR_WIDTH-1:0]     axi_araddr;
    logic                          axi_arready;
    logic [AXI_DATA_WIDTH-1:0]     axi_rdata;
    logic [1:0]                    axi_rresp;
    logic                          axi_rvalid;

    // Assign output wires

    assign s_axi_awready = axi_awready;
    assign s_axi_wready  = axi_wready;
    assign s_axi_bresp   = axi_bresp;
    assign s_axi_bvalid  = axi_bvalid;
    assign s_axi_arready = axi_arready;
    assign s_axi_rdata   = axi_rdata;
    assign s_axi_rresp   = axi_rresp;
    assign s_axi_rvalid  = axi_rvalid;

    // ------------------------------------------------------------------------
    // Write Address & Write Data Channel Handshaking
    // ------------------------------------------------------------------------
    logic aw_en;

    always_ff @(posedge s_axi_aclk or negedge s_axi_aresetn) begin
        if (!s_axi_aresetn) begin
            axi_awready <= 1'b0;
            axi_awaddr  <= '0;
            aw_en       <= 1'b1;
        end else begin
            if (!axi_awready && s_axi_awvalid && s_axi_wvalid && aw_en) begin
                axi_awready <= 1'b1;
                axi_awaddr  <= s_axi_awaddr;
                aw_en       <= 1'b0;
            end else if (s_axi_bready && axi_bvalid) begin
                aw_en       <= 1'b1;
                axi_awready <= 1'b0;
            end else begin
                axi_awready <= 1'b0;
            end
        end
    end

    always_ff @(posedge s_axi_aclk or negedge s_axi_aresetn) begin
        if (!s_axi_aresetn) begin
            axi_wready <= 1'b0;
        end else begin
            if (!axi_wready && s_axi_wvalid && s_axi_awvalid && aw_en) begin
                axi_wready <= 1'b1;
            end else begin
                axi_wready <= 1'b0;
            end
        end
    end

    // ------------------------------------------------------------------------
    // Write Register Logic & Strobe Generation
    // ------------------------------------------------------------------------
    logic slv_reg_wren;
    assign slv_reg_wren = axi_wready && s_axi_wvalid && axi_awready && s_axi_awvalid;

    always_ff @(posedge s_axi_aclk or negedge s_axi_aresetn) begin
        if (!s_axi_aresetn) begin
            reg_data_q   <= '0;
            irq_en_q     <= '0;
            tx_data_in_q <= '0;
            tx_w_en_q    <= 1'b0;
        end else begin
            tx_w_en_q <= 1'b0; // pulse default 0
            if (slv_reg_wren) begin
                case (axi_awaddr[4:2])
                    3'b000: begin // 0x00: CTRL_REG
                        for (int byte_index = 0; byte_index < (AXI_DATA_WIDTH/8); byte_index++) begin
                            if (s_axi_wstrb[byte_index]) begin
                                reg_data_q[(byte_index*8) +: 8] <= s_axi_wdata[(byte_index*8) +: 8];
                            end
                        end
                    end
                    3'b001: begin // 0x04: IRQ_EN_REG
                        if (s_axi_wstrb[0]) begin
                            irq_en_q <= s_axi_wdata[IR_SIZE-1:0];
                        end
                    end
                    3'b011: begin // 0x0C: TX_DATA_REG
                        if (s_axi_wstrb[0]) begin
                            tx_data_in_q <= s_axi_wdata[WIDTH-1:0];
                            tx_w_en_q    <= 1'b1; // 1-cycle write enable pulse
                        end
                    end
                    default: ;
                endcase
            end
        end
    end

    // ------------------------------------------------------------------------
    // Write Response Channel Logic
    // ------------------------------------------------------------------------
    always_ff @(posedge s_axi_aclk or negedge s_axi_aresetn) begin
        if (!s_axi_aresetn) begin
            axi_bvalid <= 1'b0;
            axi_bresp  <= 2'b00; // OKAY response
        end else begin
            if (axi_awready && s_axi_awvalid && ~axi_bvalid && axi_wready && s_axi_wvalid) begin
                axi_bvalid <= 1'b1;
                axi_bresp  <= 2'b00;
            end else if (s_axi_bready && axi_bvalid) begin
                axi_bvalid <= 1'b0;
            end
        end
    end

    // ------------------------------------------------------------------------
    // Read Address Channel Handshaking
    // ------------------------------------------------------------------------
    logic rx_read_pending_1;
    logic rx_read_pending_2;

    always_ff @(posedge s_axi_aclk or negedge s_axi_aresetn) begin
        if (!s_axi_aresetn) begin
            axi_arready <= 1'b0;
            axi_araddr  <= '0;
        end else begin
            if (!axi_arready && s_axi_arvalid && !rx_read_pending_1 && !rx_read_pending_2 && !axi_rvalid) begin
                axi_arready <= 1'b1;
                axi_araddr  <= s_axi_araddr;
            end else begin
                axi_arready <= 1'b0;
            end
        end
    end

    // ------------------------------------------------------------------------
    // Read Data & Read Strobe Logic
    // ------------------------------------------------------------------------
    logic slv_reg_rden;
    assign slv_reg_rden = axi_arready && s_axi_arvalid && ~axi_rvalid;

    always_ff @(posedge s_axi_aclk or negedge s_axi_aresetn) begin
        if (!s_axi_aresetn) begin
            axi_rvalid        <= 1'b0;
            axi_rresp         <= 2'b00;
            axi_rdata         <= '0;
            rx_r_en_q         <= 1'b0;
            rx_read_pending_1 <= 1'b0;
            rx_read_pending_2 <= 1'b0;
        end else begin
            rx_r_en_q <= 1'b0; // pulse default 0

            if (slv_reg_rden) begin
                if (axi_araddr[4:2] == 3'b100) begin
                    // RX FIFO read requires pulsing rx_r_en and waiting for FIFO output register
                    rx_r_en_q         <= 1'b1;
                    rx_read_pending_1 <= 1'b1;
                end else begin
                    axi_rvalid <= 1'b1;
                    axi_rresp  <= 2'b00; // OKAY response

                    case (axi_araddr[4:2])
                        3'b000: begin // 0x00: CTRL_REG
                            axi_rdata <= reg_data_q;
                        end
                        3'b001: begin // 0x04: IRQ_EN_REG
                            axi_rdata <= {{(AXI_DATA_WIDTH-IR_SIZE){1'b0}}, irq_en_q};
                        end
                        3'b010: begin // 0x08: STATUS_REG
                            axi_rdata <= {
                                {(AXI_DATA_WIDTH-8){1'b0}},
                                irq,
                                busy,
                                rx_fifo_done,
                                rx_fifo_empty,
                                rx_fifo_full,
                                tx_fifo_done,
                                tx_fifo_empty,
                                tx_fifo_full
                            };
                        end
                        3'b011: begin // 0x0C: TX_DATA_REG
                            axi_rdata <= {{(AXI_DATA_WIDTH-WIDTH){1'b0}}, tx_data_in_q};
                        end
                        default: begin
                            axi_rdata <= '0;
                        end
                    endcase
                end
            end else if (rx_read_pending_1) begin
                rx_read_pending_1 <= 1'b0;
                rx_read_pending_2 <= 1'b1;
            end else if (rx_read_pending_2) begin
                rx_read_pending_2 <= 1'b0;
                axi_rvalid        <= 1'b1;
                axi_rresp         <= 2'b00;
                axi_rdata         <= {{(AXI_DATA_WIDTH-WIDTH){1'b0}}, rx_data_out};
            end else if (axi_rvalid && s_axi_rready) begin
                axi_rvalid <= 1'b0;
            end
        end
    end

    // ------------------------------------------------------------------------
    // SPI Top Module Instantiation
    // ------------------------------------------------------------------------
    spi_top #(
        .WIDTH(WIDTH),
        .SIZE(SIZE),
        .FIFO_DEPTH(FIFO_DEPTH),
        .IR_SIZE(IR_SIZE)
    ) spi_top_inst (
        .clk          (s_axi_aclk),
        .rst_n        (s_axi_aresetn),
        .sclk         (sclk),
        .mosi         (mosi),
        .miso         (miso),
        .cs_n         (cs_n),
        .reg_data     (reg_data_q),
        .tx_data_in   (tx_data_in_q),
        .tx_w_en      (tx_w_en_q),
        .tx_fifo_full (tx_fifo_full),
        .tx_fifo_empty(tx_fifo_empty),
        .tx_fifo_done (tx_fifo_done),
        .rx_data_out  (rx_data_out),
        .rx_r_en      (rx_r_en_q),
        .rx_fifo_full (rx_fifo_full),
        .rx_fifo_empty(rx_fifo_empty),
        .rx_fifo_done (rx_fifo_done),
        .irq_en       (irq_en_q),
        .irq          (irq),
        .busy         (busy)
    );

endmodule
