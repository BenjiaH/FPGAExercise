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


module multi_sel(
    input       [7:0]   d,
    input               clk,
    input               rst,
    output  reg         input_grant,
    output  reg [10:0]  out
    );

reg     [7:0]   dBuffer;
reg     [1:0]   resultCounter;
reg     [10:0]  outBuffer;

always @(posedge clk or negedge rst)
    if(!rst)
        resultCounter <= 2'd0;
    else if(resultCounter == 2'd3)
        resultCounter <= 2'd0;
    else
        resultCounter <= resultCounter + 2'd1;

always @(posedge clk or negedge rst)
    if(!rst) 
        begin
            dBuffer <= 8'd0;
            input_grant <= 1'b0;
        end
    else if(resultCounter == 2'd0)
        begin
            input_grant <= 1'b1;
            dBuffer <= d;
        end
    else
        begin
            input_grant <= 1'b0;
            dBuffer <= dBuffer;
        end

always @(posedge clk or negedge rst)
    if(!rst)
        begin
            outBuffer <= 11'd0;
            // out <= 11'd0;
        end
    else
        begin
            case(resultCounter)
                2'd0: begin
                    // d * 1
                    outBuffer <= d;
                    // out <= d;
                end
                2'd1: begin
                    // d + d * 2 = d * 3
                    outBuffer <= (dBuffer << 2) - dBuffer;
                    // out <= (dBuffer << 2) - dBuffer;
                end
                2'd2: begin
                    // d + d * 2 + d * 4 = d * 7
                    outBuffer <= (dBuffer << 3) - dBuffer;
                    // out <= (dBuffer << 3) - dBuffer;
                end
                2'd3: begin
                    // d * 8
                    outBuffer <= dBuffer << 3;
                    // out <= dBuffer << 3;
                end
                default: begin
                    outBuffer <= 11'd0;
                    // out <= 11'd0;
                end
            endcase
        end
        
always @(*)
    out <= outBuffer;

endmodule
