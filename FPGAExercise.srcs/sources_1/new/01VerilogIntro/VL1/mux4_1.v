`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/25 15:06:54
// Design Name: 
// Module Name: mux4_1
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


module mux4_1(
    input   [1:0]   d1,d2,d3,d0,
    input   [1:0]   sel,
    output  [1:0]   mux_out
);

assign mux_out = (sel == 2'b00) ? d3 : ((sel == 2'b01) ? d2 : ((sel == 2'b10) ? d1 : d0));
//*************code***********//

endmodule
