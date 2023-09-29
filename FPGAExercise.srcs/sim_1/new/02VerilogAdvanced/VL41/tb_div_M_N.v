`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/28 22:01:15
// Design Name: 
// Module Name: tb_div_M_N
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


module tb_div_M_N();

reg     tb_clk_in;
reg     tb_rst;
wire    tb_clk_out;

always #2.5 tb_clk_in = ~tb_clk_in;

initial begin
    tb_clk_in <= 1'b1;
    tb_rst <= 1'b0;
    #10
    tb_rst <= 1'b1;

end

div_M_N div_M_N_inst(
    .clk_in     (tb_clk_in ),
    .rst        (tb_rst    ),
    .clk_out    (tb_clk_out)
    );


endmodule
