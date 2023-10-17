`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/01 16:00:45
// Design Name: 
// Module Name: tb_width_8to16
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


module tb_width_8to16();

reg             tb_clk;
reg             tb_rst_n;
reg             tb_valid_in;
reg     [7:0]   tb_data_in;

wire            tb_valid_out;
wire    [15:0]  tb_data_out;

always #2.5 tb_clk = ~tb_clk;

initial begin
    tb_clk <= 1'b1;
    tb_rst_n <= 1'b0;
    tb_valid_in <= 1'b0;
    #10
    tb_rst_n <= 1'b1;
    #0
    
    tb_valid_in <= 1'b1;
    tb_data_in <= 8'ha0;
    #5
    tb_data_in <= 8'ha1;
    #5
    tb_data_in <= 8'hb0;
    #5
    tb_valid_in <= 1'b0;
    #15
    tb_valid_in <= 1'b1;
    tb_data_in <= 8'hb1;
    #5
    tb_valid_in <= 1'b0;
    
end

width_8to16 width_8to16_inst(
    .clk       (tb_clk),   
    .rst_n     (tb_rst_n),
    .valid_in  (tb_valid_in),
    .data_in   (tb_data_in),
    .valid_out (tb_valid_out),
    .data_out  (tb_data_out)
);


endmodule
