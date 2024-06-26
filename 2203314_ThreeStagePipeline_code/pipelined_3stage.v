`timescale 1ns / 1ps
`include "define.v"

module pipelined_3stage(clk, rst, aluout);

input clk;															
input rst;

output [`DSIZE-1:0] aluout;	

wire [`ISIZE-1:0] addr_to_imm;

wire [`ISIZE-1:0] mem_inst_out;

wire [`ISIZE-1:0] reg_inst_out;

PC1 pc_inst (
    .clk(clk),
    .rst(rst),
    .nextPC(addr_to_imm),
    .currPC(addr_to_imm)
);

memory mem_inst (
    .clk(clk),
    .rst(rst),
    .wen(), // For instruction memory, writing is disabled
    .addr(addr_to_imm),
    .data_in(), // No data input needed for instruction memory
    .fileid(0),  // Select instruction memory file
    .data_out(mem_inst_out)
);

ID_IFstage ID_IF0(
    .clk(clk),
    .rst(rst),
    .instin(mem_inst_out),
    .inst(reg_inst_out)
);

datapath_mux DP0(
    .clk(clk),
    .rst(rst),
    .inst(reg_inst_out),
    .aluout(aluout)
);

endmodule



