`include"define.v"
`timescale 1ns / 1ps

module EXE_WBstage(
    clk,
    rst,
    aluout_in,
    waddr_in,
    aluout_out,
    waddr_out
    );
    
input clk, rst;

// Inputs that go through the EXE_WB stage register
input  [`DSIZE-1:0] aluout_in;
input [`ASIZE-1:0] waddr_in;

// Outputs that come out from the EXE_WB stage registser
output reg [`DSIZE-1:0] aluout_out;
output reg [`ASIZE-1:0] waddr_out;

always @(posedge clk)
begin
    if (rst)
    begin
       aluout_out <= 0;
       waddr_out <= 0;
    end
    else
    begin
       aluout_out <= aluout_in;  
       waddr_out <= waddr_in;
    end
 end  
 
endmodule
