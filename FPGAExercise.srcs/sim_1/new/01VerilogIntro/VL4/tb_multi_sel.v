`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/26 20:41:54
// Design Name: 
// Module Name: multi_sel
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


module tb_multi_sel();

reg     [7:0]   tb_d;
reg             tb_clk;
reg             tb_rst;
wire            tb_input_grant;
wire    [10:0]  tb_out;

initial begin
    tb_clk <= 1'b1;
    tb_rst <= 1'b0;
    #10
    tb_rst <= 1'b1;
    tb_d <= 8'd143;
    #15
    tb_d <= 8'd7;
    #50
    tb_d <= 8'd6;
    #5
    tb_d <= 8'd128;
end

always #2.5 tb_clk = ~tb_clk;  //5ns

multi_sel   multi_sel_inst(
    .d              (tb_d),
    .clk            (tb_clk),
    .rst            (tb_rst),
    .input_grant    (tb_input_grant),
    .out            (tb_out)
);

endmodule
