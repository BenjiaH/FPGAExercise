`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/06 15:18:07
// Design Name: 
// Module Name: gray_counter
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


module gray_counter(
    input               clk,
    input               rst_n,
 
    output  reg [3:0]   gray_out
    );

reg     [4 : 0] binCounter;
wire    [3:0]   bin;
assign  bin = binCounter[4 : 1];

always@(posedge clk or negedge rst_n)
    if(!rst_n)
        binCounter <= 5'd0;
    else if(binCounter == 5'd31)
        binCounter <= 5'd0;
    else
        binCounter <= binCounter + 5'd1;

always@(gray_out, bin)
    begin
        gray_out[3] = bin[3];
        gray_out[2] = bin[3] ^ bin[2];
        gray_out[1] = bin[2] ^ bin[1];
        gray_out[0] = bin[1] ^ bin[0];
    end

endmodule
