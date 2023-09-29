`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/28 10:57:08
// Design Name: 
// Module Name: tb_non_overlap_sequence_detect
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


module tb_non_overlap_sequence_detect();

reg     tb_clk;
reg     tb_rst_n;
reg     tb_data;
wire    tb_match;
wire    tb_not_match;

always #2.5 tb_clk = ~tb_clk;

// 011100

initial begin
    tb_clk <= 1'b1;
    tb_rst_n <= 1'b0;
    #10
    tb_rst_n <= 1'b1;
    tb_data <= 1'b0;
    #5
    tb_data <= 1'b0;
    #5
    tb_data <= 1'b1;
    #5
    tb_data <= 1'b1;
    #5
    tb_data <= 1'b1;
    #5
    tb_data <= 1'b1;
    #5
    tb_data <= 1'b0;
    #5
    tb_data <= 1'b0;
    #5
    tb_data <= 1'b1;
    #5
    tb_data <= 1'b1;
    #5
    tb_data <= 1'b1;
    #5
    tb_data <= 1'b0;
    #5
    tb_data <= 1'b1;
end

non_overlap_sequence_detect non_overlap_sequence_detect_inst(

.clk        (tb_clk      ),
.rst_n      (tb_rst_n    ),
.data       (tb_data     ),
.match      (tb_match    ),
.not_match  (tb_not_match)

);


endmodule
