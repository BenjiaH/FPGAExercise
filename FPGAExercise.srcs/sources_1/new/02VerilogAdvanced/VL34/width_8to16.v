`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/01 16:00:20
// Design Name: 
// Module Name: width_8to16
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


module width_8to16(
	input				clk,   
	input 				rst_n,
	input				valid_in,
	input		[7:0]	data_in,
 
 	output	reg			valid_out,
	output	reg [15:0]	data_out
);

reg     [0 : 0] eightBitCounter;

always@(posedge clk or negedge rst_n)
	if(!rst_n)
		eightBitCounter <= 1'd0;
    else if(eightBitCounter == 1'd1 && valid_in == 1'b1)
//    else if(eightBitCounter == 1'd1)
		eightBitCounter <= 1'd0;
//    else if(eightBitCounter == 2'd2)
//		eightBitCounter <= 2'd0;
    else if(valid_in == 1'b1)
		eightBitCounter <= eightBitCounter + 1'd1;
	else
		eightBitCounter <= eightBitCounter;

always@(posedge clk or negedge rst_n)
	if(!rst_n)
		valid_out <= 1'b0;
	else if (eightBitCounter == 2'd1 && valid_in)
		valid_out <= 1'b1;
	else
		valid_out <= 1'b0;
wire    [7:0] data_inBuffer;
assign data_inBuffer = (valid_in && eightBitCounter == 1'd0) ? data_in : data_inBuffer;

always@(posedge clk or negedge rst_n)
	if(!rst_n)
		data_out <= 16'b0;
//	else if(!valid_out && valid_in && eightBitCounter == 1'd0)
//        data_out[15 : 8] <= data_in;
////	else if(valid_in && eightBitCounter == 2'd1)
////        data_out[15 : 8] <= data_in;
	else if(valid_in && eightBitCounter == 1'd1)
//		data_out[7 : 0] <= data_in;
		data_out <= {data_inBuffer, data_in};
	else
		data_out <= data_out;
endmodule
//test1
