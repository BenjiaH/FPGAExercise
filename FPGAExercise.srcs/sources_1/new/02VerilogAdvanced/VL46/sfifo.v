`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/29 20:21:10
// Design Name: 
// Module Name: sfifo
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

/**********************************RAM************************************/
module dual_port_RAM #(
    parameter DEPTH = 16,
    parameter WIDTH = 8
)(
    input                           wclk
    ,input                          wenc
    ,input      [$clog2(DEPTH)-1:0] waddr   //深度对2取对数，得到地址的位宽。
    ,input      [WIDTH-1:0]         wdata   //数据写入
    ,input                          rclk
    ,input                          renc
    ,input      [$clog2(DEPTH)-1:0] raddr   //深度对2取对数，得到地址的位宽。
    ,output reg [WIDTH-1:0]         rdata   //数据输出
);

reg [WIDTH-1:0] RAM_MEM [0:DEPTH-1];

always @(posedge wclk)
    if(wenc)
        RAM_MEM[waddr] <= wdata;


always @(posedge rclk)
    if(renc)
        rdata <= RAM_MEM[raddr];


endmodule  

/**********************************SFIFO************************************/
module sfifo#(
    parameter   WIDTH = 8,
    parameter   DEPTH = 16
)(
    input                       clk, 
    input                       rst_n,
    input                       winc,
    input                       rinc,
    input           [WIDTH-1:0] wdata,

    output  reg                 wfull,
    output  reg                 rempty,
    output  wire    [WIDTH-1:0] rdata
);


localparam  FIFO_ADDR_WIDTH = $clog2(DEPTH);

wire    [0 : 0]                     MSBExtendRAddr;
wire    [0 : 0]                     MSBExtendWAddr;
wire    [FIFO_ADDR_WIDTH - 1 : 0]   wAddr;
wire    [FIFO_ADDR_WIDTH - 1 : 0]   rAddr;
reg     [FIFO_ADDR_WIDTH : 0]       extendWAddr;
reg     [FIFO_ADDR_WIDTH : 0]       extendRAddr;

// Ref: Clifford E. Cummings 
assign MSBExtendWAddr = extendWAddr[FIFO_ADDR_WIDTH : FIFO_ADDR_WIDTH];
assign MSBExtendRAddr = extendRAddr[FIFO_ADDR_WIDTH : FIFO_ADDR_WIDTH];
assign wAddr = extendWAddr[FIFO_ADDR_WIDTH - 1: 0];
assign rAddr = extendRAddr[FIFO_ADDR_WIDTH - 1: 0];

always@(posedge clk or negedge rst_n)
    if(!rst_n)
        extendWAddr <= 0;
    // else if(wfull)
    //     extendWAddr <=0;
    else if(winc && !wfull)
        extendWAddr <= extendWAddr + 1'd1;
    else
        extendWAddr <= extendWAddr;

always@(posedge clk or negedge rst_n)
    if(!rst_n)
        extendRAddr <= 0;
    // else if(rempty)
    //     extendRAddr <=0;
    else if(rinc && !rempty)
        extendRAddr <= extendRAddr + 1'd1;
    else
        extendRAddr <= extendRAddr;

always@(posedge clk or negedge rst_n)
    if(!rst_n)
        begin
            wfull <= 1'b0;
            rempty <= 1'b0;
        end
    // Write full gen
    else if((wAddr == rAddr) && (MSBExtendWAddr != MSBExtendRAddr))
        wfull <= 1'b1;
    // Read empty gen
    else if((wAddr == rAddr) && (MSBExtendWAddr == MSBExtendRAddr))
        rempty <= 1'b1;
    else
        begin
            wfull <= 1'b0;
            rempty <= 1'b0;
        end

dual_port_RAM #(
    .DEPTH(DEPTH),
    .WIDTH(WIDTH)
)dual_port_RAM_inst(
    .wclk   (clk),
    .wenc   (winc),
    .waddr  (wAddr),
    .wdata  (wdata),
    .rclk   (clk),
    .renc   (rinc),
    .raddr  (rAddr),
    .rdata  (rdata)
);

endmodule
