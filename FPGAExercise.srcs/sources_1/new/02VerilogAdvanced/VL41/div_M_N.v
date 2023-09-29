`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/28 22:00:36
// Design Name: 
// Module Name: div_M_N
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


module div_M_N(
    input   wire    clk_in,
    input   wire    rst,
    output  wire    clk_out
    );

parameter M_N = 8'd87; //一组clk_out输出需要的clk_in时钟数量
parameter c89 = 8'd24; // 8/9时钟切换点
parameter div_e = 5'd8; //偶数周期
parameter div_o = 5'd9; //奇数周期
parameter CLK_COUNTER_WIDTH = $clog2(M_N);
parameter EVEN_COUNTER_WIDTH = $clog2(div_e);
parameter ODD_COUNTER_WIDTH = $clog2(div_o);

reg                                 clk_outBuffer;
reg     [CLK_COUNTER_WIDTH - 1:0]   clkCounter;
reg     [EVEN_COUNTER_WIDTH - 1:0]  evenCounter;
reg     [ODD_COUNTER_WIDTH - 1:0]   oddCounter;
reg                                 evenCounterEna;
reg                                 oddCounterEna;

always @(posedge clk_in or negedge rst) 
    if(!rst)
        clkCounter <= {CLK_COUNTER_WIDTH{1'b0}};
    else if(clkCounter == M_N - 1)
        clkCounter <= {CLK_COUNTER_WIDTH{1'b0}};
    else
        clkCounter <= clkCounter + 1;

always @(posedge clk_in or negedge rst) 
    if(!rst)
        begin
            evenCounterEna = 1'b0;
            oddCounterEna = 1'b0;
        end
    else if(clkCounter >= 0 && clkCounter <= c89 - 1)
        begin
            evenCounterEna = 1'b1;
            oddCounterEna = 1'b0;
        end
    else if(clkCounter > c89 - 1 && clkCounter <= M_N - 1)
        begin
            evenCounterEna = 1'b0;
            oddCounterEna = 1'b1;
        end
    else
        begin
            evenCounterEna = evenCounterEna;
            oddCounterEna = oddCounterEna;
        end

always @(posedge clk_in or negedge rst) 
    if(!rst)
        evenCounter <= {EVEN_COUNTER_WIDTH{1'b0}};
    else if(evenCounter == div_e - 1)
        evenCounter <= {EVEN_COUNTER_WIDTH{1'b0}};
    else if(evenCounterEna)
        evenCounter <= evenCounter + 1;
    else
        evenCounter <= evenCounter;

always @(posedge clk_in or negedge rst) 
    if(!rst)
        oddCounter <= {ODD_COUNTER_WIDTH{1'b0}};
    else if(oddCounter == div_o - 1)
        oddCounter <= {ODD_COUNTER_WIDTH{1'b0}};
    else if(oddCounterEna)
        oddCounter <= oddCounter + 1;
    else
        oddCounter <= oddCounter;

// output
always @(posedge clk_in or negedge rst) 
    if(!rst)
        clk_outBuffer <= 1'b0;
    else if(evenCounterEna == 1 && evenCounter <= ((div_e >> 1) - 1))
        clk_outBuffer <= 1'b1;
    else if(oddCounterEna == 1 && oddCounter <= ((div_o >> 1) - 1))
        clk_outBuffer <= 1'b1;
    else
        clk_outBuffer <= 1'b0;

assign clk_out = clk_outBuffer;
// assign clk_out = (oddCounterEna == 1 && oddCounter <= ((div_o >> 1) - 1)) || (evenCounterEna == 1 && evenCounter <= ((div_e >> 1) - 1));


endmodule
