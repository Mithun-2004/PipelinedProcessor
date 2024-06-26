`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: IIT Goa
// Engineer:

// 
////////////////////////////////////////////////////////////////////////////////

module test_bench_4_stage_pipeline;

	// Inputs
	reg clk;
	reg rst;
	reg fileid;


	// Outputs
	wire [31:0] wdata_out;

	// Instantiate the Unit Under Test (UUT)
	pipelined_4stage uut (
		.clk(clk), 
		.rst(rst), 
		.wdata_out(wdata_out)
	);

always #10 clk = ~clk;
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		fileid = 0;


		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here



	end
      
endmodule

