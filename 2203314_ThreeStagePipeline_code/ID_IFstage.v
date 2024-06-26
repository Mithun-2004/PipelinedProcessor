`include"define.v"
`timescale 1ns / 1ps

module ID_IFstage(
    clk,
    rst,
    instin,
    inst
    );
    
    input clk, rst;
    // IF_ID register only has instruction lines to pass through it
    input  [`ISIZE-1:0] instin;    
    output reg [`ISIZE-1:0] inst;

always @(posedge clk)
begin
    if (rst)
    begin
       inst <= 0;
    end
    else
    begin
       inst <= instin;  
    end
 end  
    
endmodule
