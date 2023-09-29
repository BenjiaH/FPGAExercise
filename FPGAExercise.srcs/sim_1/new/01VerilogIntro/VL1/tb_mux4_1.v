`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/25 16:49:14
// Design Name: 
// Module Name: tb_mux4_1
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


module tb_mux4_1();

reg     [1:0]   tb_d0, tb_d1, tb_d2, tb_d3;
reg     [1:0]   tb_sel;
wire    [1:0]   tb_mux_out;

initial
    begin
        tb_d0 <= 2'b11;
        tb_d1 <= 2'b00;
        tb_d2 <= 2'b01;
        tb_d3 <= 2'b10;
        #10
        tb_sel <= 2'b00;
        #10
        tb_sel <= 2'b01;
        #10
        tb_sel <= 2'b10;
        #10
        tb_sel <= 2'b11;
    end

mux4_1  mux4_1_inst(
    .d1         (tb_d1),
    .d2         (tb_d2),
    .d3         (tb_d3),
    .d0         (tb_d0),
    .sel        (tb_sel),
    .mux_out    (tb_mux_out)
);

endmodule
