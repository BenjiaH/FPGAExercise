`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/29 10:36:10
// Design Name: 
// Module Name: tb_asyn_fifo
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


module tb_asyn_fifo();

parameter   WIDTH = 8;
parameter   DEPTH = 16;

reg                 tb_wclk;
reg                 tb_rclk;
reg                 tb_wrstn;
reg                 tb_rrstn;
reg                 tb_winc;
reg                 tb_rinc;
reg     [WIDTH-1:0] tb_wdata;
wire                tb_wfull;
wire                tb_rempty;
wire    [WIDTH-1:0] tb_rdata;

parameter W_HALF_PERIOD = 2.5;
parameter W_PERIOD = W_HALF_PERIOD * 2;
parameter R_HALF_PERIOD = 2;
parameter R_PERIOD = R_HALF_PERIOD * 2;

always #W_HALF_PERIOD tb_wclk = ~tb_wclk;
always #R_HALF_PERIOD tb_rclk = ~tb_rclk;

always @(posedge tb_wclk or negedge tb_wrstn)
    if(!tb_wrstn)
        tb_wdata <= 0;
    else
        tb_wdata <= tb_wdata + 1;

initial begin
    tb_wclk <= 1'b1;
    tb_wrstn <= 1'b0;
    tb_winc <= 1'b0;

    #(W_PERIOD * 2)
    tb_wrstn <= 1'b1;
    #(W_PERIOD * 0)

    tb_winc <=1'b1;
    #(W_PERIOD * 20)

    #(W_PERIOD * 6)
    tb_winc <= 1'b0;
    #(W_PERIOD * 3)

    #(W_PERIOD * 2)
    tb_winc = 1'b1;
    #(W_PERIOD * 8)
    tb_winc = 1'b0;
    // #(W_PERIOD * 8)

end

initial begin
    tb_rclk <= 1'b1;
    tb_rrstn <= 1'b0;
    tb_rinc <= 1'b0;

    #(R_PERIOD * 2)
    tb_rrstn <= 1'b1;
    #(R_PERIOD * 0)

    #(R_PERIOD * 20)
    tb_rinc <= 1'b1;
    #(R_PERIOD * 6)
    
    #(R_PERIOD * 3)
    tb_rinc <= 1'b0;
    #(R_PERIOD * 2)
   
    #(R_PERIOD * 8)
    
    #(R_PERIOD * 8)
    tb_rinc = 1'b1;
end

asyn_fifo #(
    .WIDTH (WIDTH),
    .DEPTH (DEPTH)
)asyn_fifo_inst(
    .wclk   (tb_wclk  ),
    .rclk   (tb_rclk  ),
    .wrstn  (tb_wrstn ),
    .rrstn  (tb_rrstn ),
    .winc   (tb_winc  ),
    .rinc   (tb_rinc  ),
    .wdata  (tb_wdata ),
    .wfull  (tb_wfull ),
    .rempty (tb_rempty),
    .rdata  (tb_rdata )
);

endmodule
