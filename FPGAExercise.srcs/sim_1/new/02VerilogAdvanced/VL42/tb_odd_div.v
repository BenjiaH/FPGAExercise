`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/05 23:21:26
// Design Name: 
// Module Name: tb_odd_div
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


module tb_odd_div();

reg     tb_rst;
reg     tb_clk_in;
wire    tb_clk_out5;

always #2.5 tb_clk_in = ~tb_clk_in;

initial begin
    tb_clk_in <= 1'b1;
    tb_rst <= 1'b0;
    #10
    tb_rst <= 1'b1;
end


odd_div odd_div_inst(

    .rst        (tb_rst     ),
    .clk_in     (tb_clk_in  ),
    .clk_out5   (tb_clk_out5)
);

endmodule
