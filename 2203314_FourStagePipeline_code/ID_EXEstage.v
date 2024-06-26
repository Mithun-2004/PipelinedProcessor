`include "define.v"
`timescale 1ns / 1ps
//Here we need not take write enable (wen) as it is always 1 for R and I type instructions.
//ID_EXE register to save the values.

module ID_EXE_stage (
    input clk,
    input rst,
     
    // Inputs that go through the ID_EXE stage register
    input [2:0] aluop_cntrlin,
    input alusrc_cntrlin,
    input [`DSIZE-1:0] rdata1in,
    input [`DSIZE-1:0] rdata2in,
    input [`DSIZE-1:0] sign_exin,
    input [`ASIZE-1:0] waddrin,
    
    // Outputs that come from the ID_EXE stage register
    output reg [2:0] aluop_cntrl,
    output reg alusrc_cntrl,
    output reg [`DSIZE-1:0] rdata1,
    output reg [`DSIZE-1:0] rdata2,
    output reg [`DSIZE-1:0] sign_ex,
    output reg [`ASIZE-1:0] waddr
);

always @(posedge clk)
begin
    if (rst)
        begin
           aluop_cntrl <= 0;
           alusrc_cntrl <= 0;
           rdata1 <= 0;
           rdata2 <= 0;
           sign_ex <= 0;
           waddr <= 0;
        end
    else
        begin
           aluop_cntrl <= aluop_cntrlin;
           alusrc_cntrl <= alusrc_cntrlin;
           rdata1 <= rdata1in;
           rdata2 <= rdata2in;
           sign_ex <= sign_exin; 
           waddr <= waddrin;
         end
end   
    
endmodule


