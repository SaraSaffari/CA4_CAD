module mux_2_input #(parameter integer WORD_LENGTH = 8) (in1, in2, sel, out);
	input wire sel;
	input wire [WORD_LENGTH-1:0] in1, in2;
	output reg [WORD_LENGTH-1:0] out;
	always @(sel) begin
		if (sel)
			out <= in2;
		else
			out <= in1;
	end
endmodule
