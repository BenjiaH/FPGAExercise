`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/28 10:55:12
// Design Name: 
// Module Name: non_overlap_sequence_detect
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


module non_overlap_sequence_detect(
    input       clk,
    input       rst_n,
    input       data,
    output  reg match,
    output  reg not_match
    );

parameter   IDLE    = 8'b0000_0001,
            ONE     = 8'b0000_0010,
            TWO     = 8'b0000_0100,
            THREE   = 8'b0000_1000,
            FOUR    = 8'b0001_0000,
            FIVE    = 8'b0010_0000,
            CORRECT = 8'b0100_0000,
            ERROR   = 8'b1000_0000;

reg         [7:0]   currentState;
reg         [7:0]   nextState;
reg         [2:0]   dataCounter;

always @(posedge clk or negedge rst_n)
    if(!rst_n)
        dataCounter <= 3'd0;
    else if(dataCounter == 3'd5)
        dataCounter <= 3'd0;
    else
        dataCounter <= dataCounter + 3'd1;


always @(posedge clk or negedge rst_n)
    if(!rst_n)
        currentState <= IDLE;
    else
        currentState <= nextState;

always @(*)
    if(!rst_n)
        nextState = IDLE;
    else
        case(currentState)
            IDLE:begin
                if(data == 1'b0)
                    nextState = ONE;
                else
                    nextState = ERROR;
            end
            ONE:begin
                if(data == 1'b0)
                    nextState = TWO;
                else
                    nextState = ERROR;
            end
            TWO:begin
                if(data == 1'b1)
                    nextState = THREE;
                else
                    nextState = ERROR;
            end
            THREE:begin
                if(data == 1'b1)
                    nextState = FOUR;
                else
                    nextState = ERROR;
            end
            FOUR:begin
                if(data == 1'b1)
                    nextState = FIVE;
                else
                    nextState = ERROR;
            end
            FIVE:begin
                if(data == 1'b0)
                    nextState = CORRECT;
                else
                    nextState = ERROR;
            end
            CORRECT:
                if(data == 1'b0)
                    nextState = ONE;
                else
                    nextState = ERROR;
            ERROR:
                if(data == 1'b0)
                    nextState = ONE;
                else
                    nextState = ERROR;
        endcase

// always @(posedge clk or negedge rst_n)
//     if(!rst_n)
//         begin
//             match <= 1'b0;
//             not_match <= 1'b0;
//         end
//     else
//         begin
//             match <= (dataCounter == 3'd5) && (nextState == CORRECT);
//             not_match <= (dataCounter == 3'd5) && (nextState == ERROR);
//         end

always @(*)
    begin
        match = (dataCounter == 3'd5) && (nextState == CORRECT);
        not_match = (dataCounter == 3'd5) && (nextState == ERROR);
    end




endmodule
