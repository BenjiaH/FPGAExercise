`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/05 23:21:01
// Design Name: 
// Module Name: odd_div
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

module odd_div (
    input     wire rst ,
    input     wire clk_in,
    output    wire clk_out5
);

reg     [2 : 0] clkInCounter;

always @(posedge clk_in or negedge rst)
    if(!rst)
        clkInCounter <= 3'd0;
    else if(clkInCounter == 3'd4)
        clkInCounter <= 3'd0;
    else
        clkInCounter <= clkInCounter + 3'd1;

assign clk_out5 = (!rst) ? 1'b0 : ((clkInCounter >= 3'd0 && clkInCounter <= 3'd2) ? 1'b1 : 1'b0);

endmodule
