`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/29 10:35:29
// Design Name: 
// Module Name: asyn_fifo
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


/***************************************RAM*****************************************/
module dual_port_RAM #(parameter DEPTH = 16,
                       parameter WIDTH = 8)(
     input wclk
    ,input wenc
    ,input [$clog2(DEPTH)-1:0] waddr    //深度对2取对数，得到地址的位宽。
    ,input [WIDTH-1:0] wdata            //数据写入
    ,input rclk
    ,input renc
    ,input [$clog2(DEPTH)-1:0] raddr    //深度对2取对数，得到地址的位宽。
    ,output reg [WIDTH-1:0] rdata       //数据输出
);

reg [WIDTH-1:0] RAM_MEM [0:DEPTH-1];

always @(posedge wclk) begin
    if(wenc)
        RAM_MEM[waddr] <= wdata;
end 

always @(posedge rclk) begin
    if(renc)
        rdata <= RAM_MEM[raddr];
end 

endmodule  


module asyn_fifo#(
    parameter   WIDTH = 8,
    parameter   DEPTH = 16
)(
    input                       wclk,
    input                       rclk,
    input                       wrstn,
    input                       rrstn,
    input                       winc,
    input                       rinc,
    input           [WIDTH-1:0] wdata,
    output  wire                wfull,
    output  wire                rempty,
    output  wire    [WIDTH-1:0] rdata
    );


localparam  FIFO_ADDR_WIDTH = $clog2(DEPTH);

wire    [0 : 0]                     MSBExtendWAddr;
wire    [0 : 0]                     MSBExtendRAddr;

wire    [FIFO_ADDR_WIDTH - 1 : 0]   wAddr;
wire    [FIFO_ADDR_WIDTH - 1 : 0]   rAddr;

reg     [FIFO_ADDR_WIDTH : 0]       extendWAddr;
reg     [FIFO_ADDR_WIDTH : 0]       extendRAddr;

wire    [FIFO_ADDR_WIDTH : 0]       extendGrayWAddr;
wire    [FIFO_ADDR_WIDTH : 0]       extendGrayRAddr;


// Ref: Clifford E. Cummings 
assign MSBExtendWAddr = extendWAddr[FIFO_ADDR_WIDTH : FIFO_ADDR_WIDTH];
assign MSBExtendRAddr = extendRAddr[FIFO_ADDR_WIDTH : FIFO_ADDR_WIDTH];
assign wAddr = extendWAddr[FIFO_ADDR_WIDTH - 1: 0];
assign rAddr = extendRAddr[FIFO_ADDR_WIDTH - 1: 0];

// Bin to Gray
assign extendGrayWAddr = extendWAddr ^ (extendWAddr >> 1);
assign extendGrayRAddr = extendRAddr ^ (extendRAddr >> 1);

always@(posedge wclk or negedge wrstn)
    if(!wrstn)
        extendWAddr <= 0;
    // else if(wfull)
    //     extendWAddr <=0;
    else if(winc && !wfull)
        extendWAddr <= extendWAddr + 1'd1;
    else
        extendWAddr <= extendWAddr;

always@(posedge rclk or negedge rrstn)
    if(!rrstn)
        extendRAddr <= 0;
    // else if(rempty)
    //     extendRAddr <=0;
    else if(rinc && !rempty)
        extendRAddr <= extendRAddr + 1'd1;
    else
        extendRAddr <= extendRAddr;

// Tap as intrducing the the combination logic
reg     [FIFO_ADDR_WIDTH : 0]       extendGrayWAddrReg;
reg     [FIFO_ADDR_WIDTH : 0]       extendGrayRAddrReg;

always@(posedge wclk or negedge wrstn)
    if(!wrstn)
        extendGrayWAddrReg <= 'd0;
    else
        extendGrayWAddrReg <= extendGrayWAddr;

always@(posedge rclk or negedge rrstn)
    if(!rrstn)
        extendGrayRAddrReg <= 'd0;
    else
        extendGrayRAddrReg <= extendGrayRAddr;

reg     [FIFO_ADDR_WIDTH : 0]       extendGrayW2RAddrReg1;
reg     [FIFO_ADDR_WIDTH : 0]       extendGrayR2WAddrReg1;

reg     [FIFO_ADDR_WIDTH : 0]       extendGrayW2RAddrReg2;
reg     [FIFO_ADDR_WIDTH : 0]       extendGrayR2WAddrReg2;


always@(posedge rclk or negedge rrstn)
    if(!rrstn) begin
        extendGrayW2RAddrReg1 <= 'd0;
        extendGrayW2RAddrReg2 <= 'd0;
    end
    else begin
        extendGrayW2RAddrReg1 <= extendGrayWAddrReg;
        extendGrayW2RAddrReg2 <= extendGrayW2RAddrReg1;
    end

always@(posedge wclk or negedge wrstn)
    if(!wrstn) begin
        extendGrayR2WAddrReg1 <= 'd0;
        extendGrayR2WAddrReg2 <= 'd0;
    end
    else begin
        extendGrayR2WAddrReg1 <= extendGrayRAddrReg;
        extendGrayR2WAddrReg2 <= extendGrayR2WAddrReg1;
    end
// Finished to tap

// wfull and rempty
wire    MSBExtendGrayR2WAddrReg2;
wire    MSBExtendGrayW2RAddrReg2;

assign MSBExtendGrayR2WAddrReg2 = extendGrayR2WAddrReg2[FIFO_ADDR_WIDTH : FIFO_ADDR_WIDTH - 1];
assign MSBExtendGrayW2RAddrReg2 = extendGrayW2RAddrReg2[FIFO_ADDR_WIDTH : FIFO_ADDR_WIDTH - 1];

assign wfull    = (extendGrayWAddr == {~MSBExtendGrayR2WAddrReg2, extendGrayR2WAddrReg2[FIFO_ADDR_WIDTH - 2 : 0]});
assign rempty   = (extendGrayRAddr == extendGrayR2WAddrReg2);

dual_port_RAM #(
    .DEPTH(DEPTH),
    .WIDTH(WIDTH)
)dual_port_RAM_inst(
    .wclk   (clk),
    .wenc   (winc && ~wfull),
    .waddr  (wAddr),
    .wdata  (wdata),
    .rclk   (clk),
    .renc   (rinc && ~rempty),
    .raddr  (rAddr),
    .rdata  (rdata)
);

endmodule
