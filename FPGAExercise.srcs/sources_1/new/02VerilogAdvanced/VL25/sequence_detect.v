`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/27 21:42:45
// Design Name: 
// Module Name: sequence_detect
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


module sequence_detect(
    input       clk,
    input       rst_n,
    input       a,
    output  reg match
    );

parameter   TARGET_SEQUENCE = 8'b0111_0001;
parameter   SEQUENCE_WIDTH = 8;

reg         [SEQUENCE_WIDTH - 1 : 0]    sequenceReg;


always @(posedge clk or negedge rst_n)
    if(!rst_n)
        sequenceReg <= 8'b0;
    else
        sequenceReg <= {sequenceReg[SEQUENCE_WIDTH -2 : 0], a};

// assign  sequenceReg = {a, sequenceReg[SEQUENCE_WIDTH -1 : 1]};

always @(posedge clk or negedge rst_n)
    if(!rst_n)
        match <= 1'b0;
    else if(sequenceReg == TARGET_SEQUENCE)
        match <= 1'b1;
    else
        match <= 1'b0;

endmodule
