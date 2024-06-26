`timescale 1ns / 1ps


module sign_extend(
    input [15:0] in_data,
    output reg [31:0] out_data
);

always @(*) begin
    // Check the sign bit of the input data
    
    if (in_data[15] == 1'b0) 
    begin
        // If positive, extend with zeros
        out_data = {16'b0, in_data};
    end 
        
    else 
    begin
        // If negative, extend with ones
        out_data = {16'b1, in_data};
    end
end 
 

endmodule