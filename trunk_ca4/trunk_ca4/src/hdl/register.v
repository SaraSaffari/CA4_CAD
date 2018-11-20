module register  #(parameter integer size = 32)(clock, rst, enable, regIn, regOut);
    input wire clock, rst, enable;
    input wire [size - 1:0] regIn;
    output reg [size - 1: 0] regOut;
    
    always @(posedge clock) begin
    	if (rst) regOut <= 0;
    	else if (enable) regOut <= regIn;        
    end
endmodule