`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/29 20:21:33
// Design Name: 
// Module Name: tb_sfifo
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


module tb_sfifo();

parameter   WIDTH = 8;
parameter   DEPTH = 16;

reg                 tb_clk;
reg                 tb_rst_n;
reg                 tb_winc;
reg                 tb_rinc;
reg     [WIDTH-1:0] tb_wdata;
wire                tb_wfull;
wire                tb_rempty;
wire    [WIDTH-1:0] tb_rdata;

parameter HALF_PERIOD = 2.5;
parameter PERIOD = HALF_PERIOD * 2;

always #HALF_PERIOD tb_clk = ~tb_clk;

always @(posedge tb_clk or negedge tb_rst_n)
    if(!tb_rst_n)
        tb_wdata <= 0;
    else
        tb_wdata <= tb_wdata + 1;

initial begin
    tb_clk <= 1'b1;
    tb_rst_n <= 1'b0;
    tb_winc <= 1'b0;
    tb_rinc <= 1'b0;
    #(PERIOD * 2)
    tb_rst_n <= 1'b1;
    #(PERIOD * 0)

    tb_winc <=1'b1;
    #(PERIOD * 20)
    tb_rinc <= 1'b1;
    #(PERIOD * 6)
    tb_winc <= 1'b0;
    #(PERIOD * 3)
    tb_rinc <= 1'b0;
    #(PERIOD * 2)
    tb_winc = 1'b1;
    #(PERIOD * 8)
    tb_winc = 1'b0;
    #(PERIOD * 8)
    tb_rinc = 1'b1;
end

sfifo #(
    .WIDTH (WIDTH),
    .DEPTH (DEPTH)
)sfifo_inst(
    .clk    (tb_clk   ), 
    .rst_n  (tb_rst_n ),
    .winc   (tb_winc  ),
    .rinc   (tb_rinc  ),
    .wdata  (tb_wdata ),
    .wfull  (tb_wfull ),
    .rempty (tb_rempty),
    .rdata  (tb_rdata )
);

endmodule
