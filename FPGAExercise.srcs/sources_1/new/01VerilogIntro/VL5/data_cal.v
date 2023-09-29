`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/27 14:55:09
// Design Name: 
// Module Name: data_cal
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


module data_cal(
    input clk,
    input rst,
    input [15:0] d,
    input [1:0] sel,
    output [4:0] out,
    output validout
    );

reg     [15:0]  dBuffer;
wire    [3:0]   data1;
wire    [7:4]   data2;
wire    [11:8]  data3;
wire    [15:12] data4;
reg     [4:0]   outBuffer;
reg     [4:0]   validoutBuffer;

assign  data1 = dBuffer[3:0];
assign  data2 = dBuffer[7:4];
assign  data3 = dBuffer[11:8];
assign  data4 = dBuffer[15:12];

always @(posedge clk or negedge rst)
    if(!rst)
        dBuffer <= 16'd0;
    else if(sel == 2'd0)
        dBuffer <= d;
    else
        dBuffer <= dBuffer;

always @(posedge clk or negedge rst)
    if(!rst)
        begin
            outBuffer <= 5'd0;
            validoutBuffer <= 1'b0;
        end
    else
        case(sel)
            2'd0: begin
                outBuffer <= 5'd0;
                validoutBuffer <= 1'b0;
            end
            2'd1: begin
                outBuffer <= data1 + data2;
                validoutBuffer <= 1'b1;
            end
            2'd2: begin
                outBuffer <= data1 + data3;
                validoutBuffer <= 1'b1;
            end
            2'd3: begin
                outBuffer <= data1 + data4;
                validoutBuffer <= 1'b1;
            end
            default: begin
                outBuffer <= 5'd0;
                validoutBuffer <= 1'b0;
            end
        endcase
    
assign  out = outBuffer;
assign  validout = validoutBuffer;

endmodule
