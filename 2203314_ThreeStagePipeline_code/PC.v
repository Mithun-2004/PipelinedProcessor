`include "define.v"


module PC1(
       clk,
		 rst,       
		 nextPC,		 
		 currPC);
		 
		  
		 input clk,rst;		 
		 input [`ISIZE - 1:0]nextPC;		 //instruction address is 16 bit as it can address more memory locations
		 output reg [`ISIZE - 1:0]currPC;
		 
		 
always @(posedge clk)
begin
    if (rst)
       begin
       currPC <= 0;
       end
    else
        begin
       currPC <= nextPC + 1; // Current PC value is one more than the Next PC value
        
       end   
end

endmodule	

