`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/25 17:43:53
// Design Name: 
// Module Name: tb_tff_2
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


module tb_tff_2();

reg     tb_clk, tb_rst, tb_data;
wire    tb_q;

// wire    tb_q_tff1;

initial
    begin
        tb_clk <= 1'b0;
        tb_rst <= 1'b0;
        tb_data <= 1'b0;
        #5
        tb_rst <= 1'b1;
        tb_data <= 1'b1;
        #10
        tb_data <= 1'b0;
        #5
        tb_data <= 1'b1;
        #5
        tb_data <= 1'b0;
        #15
        tb_data <= 1'b1;
    end

always #2.5 tb_clk = ~tb_clk;  //50Mhz

tff_2   tff_2_inst(
    .clk    (tb_clk),
    .rst    (tb_rst),
    .data   (tb_data),
    .q      (tb_q)
);

endmodule
