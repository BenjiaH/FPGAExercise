`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/25 20:47:58
// Design Name: 
// Module Name: odd_sel
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


module odd_sel(
    input   [31:0]  bus,
    input           sel,
    output          check
    );

wire    oddCounts;
reg     checkOutBuffer;

assign  oddCounts = ^bus;

always @(*)
    if (sel)
        checkOutBuffer <= oddCounts;
    else
        checkOutBuffer <= ~oddCounts;

assign  check = checkOutBuffer;

endmodule
