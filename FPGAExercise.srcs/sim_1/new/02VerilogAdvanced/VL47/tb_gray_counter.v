`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/06 15:18:29
// Design Name: 
// Module Name: tb_gray_counter
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


module tb_gray_counter();

reg             tb_clk;
reg             tb_rst_n;

wire    [3:0]   tb_gray_out;

always #2.5 tb_clk = ~tb_clk;

initial begin
    tb_clk <= 1'b1;
    tb_rst_n <= 1'b0;
    #10
    tb_rst_n <= 1'b1;
end

gray_counter    gray_counter_inst(
    .clk        (tb_clk     ),
    .rst_n      (tb_rst_n   ),
    .gray_out   (tb_gray_out)
);

endmodule
