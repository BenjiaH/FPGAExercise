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


parameter   FIFO_ADDR_WIDTH = $clog2(DEPTH);

reg     [FIFO_ADDR_WIDTH - 1 : 0]   wAddr;
reg     [FIFO_ADDR_WIDTH - 1 : 0]   rAddr;

always@(posedge wclk or negedge wrstn)
    if(!wrstn)
        wAddr <= 0;
    else if(wfull)
        wAddr <=0;
    else if(winc && !wfull)
        wAddr <= wAddr + 1'd1;

always@(posedge rclk or negedge rrstn)
    if(!rrstn)
        rAddr <= 0;
    else if(rempty)
        rAddr <=0;
    else if(rinc && !rempty)
        rAddr <= rAddr + 1'd1;

endmodule
