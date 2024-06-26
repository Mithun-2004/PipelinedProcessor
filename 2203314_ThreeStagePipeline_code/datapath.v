`include"define.v"
`timescale 1ns / 1ps

module datapath_mux (
	// inputs
	clk,
	rst,
	inst,

	//outputs
	aluout
);

// inputs
input		  clk;
input		  rst;
input  [`ISIZE-1:0] inst;


// outputs
output  [`DSIZE-1:0] aluout;

wire [2:0]	aluop;
wire alusrc;
wire regDST;
wire wen;
wire [`DSIZE-1:0] rdata1;
wire [`DSIZE-1:0] rdata2;
wire [`ASIZE-1:0] waddr_out;

wire [`DSIZE-1:0]rdata2_imm; // sign extending if i type instruction

wire [`ASIZE-1:0]waddr_regDST=regDST ? inst[15:11] : inst[20:16];//Multiplexer to select the inst[15:11] or inst[20:16] as the waddr based on regDST.
//when regDST is 1 then connect inst[15:11] to output else connect inst[20:16] to output

// Output wires from ID/EXE stage register
wire [2:0] regout_aluop;
wire regout_alusrc;
wire [`DSIZE-1:0] regout_rdata1;
wire[`DSIZE-1:0] regout_rdata2;
wire [`DSIZE-1:0] regout_rdata2_imm;
// wire [`ISIZE-1:0] regout_waddr; // this is waddr_out

wire [`DSIZE-1:0] rdata2_final = regout_alusrc ? regout_rdata2_imm : regout_rdata2; // This is the rdata2 dataline that is either immediate value or from register which is chosen based on alusrc

//Here you need to instantiate the control , Alu , regfile and the delay registers. 
control C0(
    .inst_cntrl(inst[31:26]),
    .wen_cntrl(wen),
    .alusrc_cntrl(alusrc),
    .regdst_cntrl(regDST),
    .aluop_cntrl(aluop)
);

sign_extend SE0(
    .in_data(inst[15:0]),
    .out_data(rdata2_imm)
);

regfile RF0(
    .clk(clk),
    .rst(rst),
    .wen(wen),
    .raddr1(inst[25:21]),
    .raddr2(inst[20:16]),
    .waddr(waddr_out),
    .wdata(aluout),
    .rdata1(rdata1),
    .rdata2(rdata2)
);

ID_EXE_stage ID_EXE0(
    .clk(clk),
    .rst(rst),
     
    .aluop_cntrlin(aluop),
    .alusrc_cntrlin(alusrc),
    .rdata1in(rdata1),
    .rdata2in(rdata2),
    .sign_exin(rdata2_imm),
    .waddrin(waddr_regDST),
    
    .aluop_cntrl(regout_aluop),
    .alusrc_cntrl(regout_alusrc),
    .rdata1(regout_rdata1),
    .rdata2(regout_rdata2),
    .sign_ex(regout_rdata2_imm),
    .waddr(waddr_out)
);


alu ALU0(
    .a(regout_rdata1),
    .b(rdata2_final),
    .op(regout_aluop),
    .out(aluout)
);


//-insert your code here




endmodule // end of datapath module

