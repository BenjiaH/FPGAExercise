`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/27 14:55:45
// Design Name: 
// Module Name: tb_data_cal
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


module tb_data_cal();

reg             tb_clk;
reg             tb_rst;
reg     [15:0]  tb_d;
reg     [1:0]   tb_sel;
wire    [4:0]   tb_out;
wire            tb_validout;

always #5 tb_clk = ~tb_clk;

initial begin
    tb_clk <= 1'b0;
    tb_rst <= 1'b0;
    tb_d <= 16'd0;
    tb_sel <= 2'd0;
    #10
    tb_rst <= 1'b1;
    tb_d <= 16'b0010_0011_0100_0101;
    tb_sel <= 2'd0;
    #10
    tb_sel <= 2'd1;
    #10
    tb_sel <= 2'd2;
    #10
    tb_d <= 16'b0100_0101_0010_0011;
    tb_sel <= 2'd3;
end

data_cal    data_cal_inst(
    .clk        (tb_clk),
    .rst        (tb_rst),
    .d          (tb_d),
    .sel        (tb_sel),
    .out        (tb_out),
    .validout   (tb_validout)
    );

endmodule
