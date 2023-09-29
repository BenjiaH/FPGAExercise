`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/27 21:43:56
// Design Name: 
// Module Name: tb_sequence_detect
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


module tb_sequence_detect();

reg     tb_clk;
reg     tb_rst_n;
reg     tb_a;
wire    tb_match;

always #2.5 tb_clk = ~tb_clk;
// 0111_0001
initial begin
    tb_clk <= 1'b1;
    tb_rst_n <= 1'b0;
    #20
    tb_rst_n <= 1'b1;
    tb_a <= 1'b0;
    #5
    tb_a <= 1'b1;
    #5
    tb_a <= 1'b1;
    #5
    tb_a <= 1'b1;
    #5
    tb_a <= 1'b0;
    #5
    tb_a <= 1'b0;
    #5
    tb_a <= 1'b1;
    #5
    tb_a <= 1'b1;
    #5
    tb_a <= 1'b0;
    #5
    tb_a <= 1'b1;
    #5
    tb_a <= 1'b1;
    #5
    tb_a <= 1'b1;
    #5
    tb_a <= 1'b0;
    #5
    tb_a <= 1'b0;
    #5
    tb_a <= 1'b0;
    #5
    tb_a <= 1'b1;
    #5
    tb_a <= 1'b0;
end

sequence_detect sequence_detect_inst(
    .clk    (tb_clk  ),
    .rst_n  (tb_rst_n),
    .a      (tb_a    ),
    .match  (tb_match)
);

endmodule
