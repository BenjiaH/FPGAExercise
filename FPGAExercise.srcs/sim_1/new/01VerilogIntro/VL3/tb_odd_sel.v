`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/25 21:00:03
// Design Name: 
// Module Name: tb_odd_sel
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


module tb_odd_sel();

reg     [31:0]  tb_bus;
reg             tb_sel;
wire            tb_check;

initial 
    begin
        tb_bus <= 32'd0;
        #1
        tb_bus <= 32'hF;
        tb_sel <= 1'b1;
        #1
        tb_sel <= 1'b0;
        #1
        tb_bus <= 32'hE;
        tb_sel <= 1'b1;
        #1
        tb_sel <= 1'b0;
    end

odd_sel odd_sel_inst(
    .bus    (tb_bus),
    .sel    (tb_sel),
    .check  (tb_check)
);

endmodule
