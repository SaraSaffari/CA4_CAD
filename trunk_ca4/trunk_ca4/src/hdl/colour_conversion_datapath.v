module colour_conversion_datapath#(
	parameter [19:0] x1y1 = 20'd 76284,
	parameter [19:0] x2y1 = 20'd 0,
	parameter [19:0] x3y1 = 20'd 104595,

	parameter [19:0] x1y2 = 20'd 76284,
	parameter [19:0] x2y2 = -20'd 25624,
	parameter [19:0] x3y2 = -20'd 53281,

	parameter [19:0] x1y3 = 20'd 76284,
	parameter [19:0] x2y3 = 20'd 132251,
	parameter [19:0] x3y3 = 20'd 0
	)
	(clk, rst, R_data, Yen_odd, Uen_odd, Ven_odd, Yen_even, Uen_even, Ven_even,
		Smux1, Smux2, Cen, Temp_en, end_of_pixel, W_data);

	input clk, rst, Cen, Temp_en, Yen_odd, Uen_odd, Ven_odd, Yen_even, Uen_even, Ven_even, Smux1;
	input[1:0] Smux2;
	input[15:0] R_data;

	output end_of_pixel;
	output[15:0] W_data;
  
  	wire [17:0] R_addr;
	wire Y_even_out, U_even_out, V_even_out;
	wire Y_odd_out, U_odd_out, V_odd_out;
	wire [59:0]outMux1, outMux2;
	wire [15:0] out_combinational;
	wire out_Temp;
	wire result_0, result_1, result_2;

	parameter[19:0] a_third_of_all_pixels = 20'd 38400;    
	assign end_of_pixel = a_third_of_all_pixels - R_addr ? 0 : 1;

	register #(.size(8)) Y_even(
		.clock(clk),
		.rst(rst),
		.enable(Yen_even),
		.regIn(R_data[7:0]),
		.regOut(Y_even_out));
	
	register #(.size(8)) U_even(
		.clock(clk),
		.rst(rst),
		.enable(Uen_even),
		.regIn(R_data[7:0]),
		.regOut(U_even_out));
	
	register #(.size(8)) V_even(
		.clock(clk),
		.rst(rst),
		.enable(Ven_even),
		.regIn(R_data[7:0]),
		.regOut(V_even_out));

	register #(.size(8)) Y_odd(
		.clock(clk),
		.rst(rst),
		.enable(Yen_odd),
		.regIn(R_data[15:8]),
		.regOut(Y_odd_out));

	register #(.size(8)) U_odd(
		.clock(clk),
		.rst(rst),
		.enable(Uen_odd),
		.regIn(R_data[15:8]),
		.regOut(U_odd_out));

	register #(.size(8)) V_odd(
		.clock(clk),
		.rst(rst),
		.enable(Ven_odd),
		.regIn(R_data[15:8]),
		.regOut(V_odd_out));

	counterr cnt (
		.clk(clk),
		.reset(rst),
		.en(Cen),
		.counter(R_addr));

	mux_2_input #(.WORD_LENGTH (8)) mux1(
		.in1({Y_odd_out, U_odd_out, V_odd_out}),   
		.in2({Y_even_out, U_even_out, V_even_out}),
		.sel(Smux1),
		.out(outMux1));

	// matrix
	// 76284 0 104595
	// 76284 −25624 −53281
	// 76284 132251 0

	// these numbers should be mux's input but how do we seprate them?
	mux_3_input #(.WORD_LENGTH (60)) mux2(
		.in1({x1y1, x2y1, x3y1}), 
		.in2({x1y2, x2y2, x3y3}), 
		.in3({x1y3, x2y3, x3y3}), 
		.sel(Smux2),
		.out(outMux2));

	assign result_2 = ($signed(outMux2[59:40]) * ({12'b 0 ,outMux1[23:16]} - 20'd 16 ) ) / 20'd 65536; 
	assign result_1 = ($signed(outMux2[39:20]) * ({12'b 0 ,outMux1[15: 7]} - 20'd 128) ) / 20'd 65536;
	assign result_0 = ($signed(outMux2[19: 0]) * ({12'b 0 ,outMux1[7 : 0]} - 20'd 128) ) / 20'd 65536;

	assign out_combinational = $signed(result_2) + $signed(result_1) + $signed(result_0) > 8'd255 ? 8'd255 : 
	$signed(result_2) + $signed(result_1) + $signed(result_0) < 8'd000 ? 8'd000 : 
	$signed(result_2) + $signed(result_1) + $signed(result_0);

	// if ($signed(result_2) + $signed(result_1) + $signed(result_0) > 8'd255) assign out_combinational =  8'd255;
	// if ($signed(result_2) + $signed(result_1) + $signed(result_0) < 8'd0) assign out_combinational =  8'd0;
	// else assign out_combinational = { $signed(result_2) + $signed(result_1) + $signed(result_0)};

	register #(.size(16)) Temp( //is the size ok??
		.clock(clk),
		.rst(rst),
		.enable(Temp_en),
		.regIn(out_combinational),
		.regOut(out_Temp));

	assign W_data = {out_Temp, out_combinational}; //is the order ok??
endmodule

	