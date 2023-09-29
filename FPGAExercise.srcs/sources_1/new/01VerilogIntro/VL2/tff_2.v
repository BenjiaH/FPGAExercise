`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/25 17:21:21
// Design Name: 
// Module Name: tff_2
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


module tff_2(
    input   wire    clk,
    input   wire    rst,
    input   wire    data,
    output  reg     q
);

reg q_tff1;

// T-flipflop 1
always@(posedge clk or negedge rst)
    if (!rst)
        q_tff1 <= 1'b0;
    else if (data)
        q_tff1 <= ~q_tff1;
    else
        q_tff1 <= q_tff1;

// T-flipflop 2
always@(posedge clk or negedge rst)
    if (!rst)
        q <= 1'b0;
    else if (q_tff1)
        q <= ~q;
    else
        q <= q;

endmodule
