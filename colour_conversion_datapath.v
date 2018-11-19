module colour_conversion_datapath(clk, rst, R_data, Yen_odd, Uen_odd, Ven_odd, Yen_even, Uen_even, Ven_even,
	Smux1, Smux2, Cen, Temp_en, end_of_pixel, W_data, R_addr);

	input clk, rst, Cen, Temp_en, Yen_odd, Uen_odd, Ven_odd, Yen_even, Uen_even, Ven_even, Smux1;
	input[1:0] Smux2;
	input[15:0] R_data;

	output end_of_pixel;
	output[15:0] W_data;

	wire Y_even_out, U_even_out, V_even_out;
	wire Y_odd_out, U_odd_out, V_odd_out;
	wire outMux1, outMux2;
	wire out_combinational;
	wire out_Temp;

	parameter[19:0] a_third_of_all_pixels = 20'd 38400;    //do we still need it??
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
		.in1({Y_odd_out, U_odd_out, V_odd_out}),   //is the order ok??
		.in2({Y_even_out, U_even_out, V_even_out}),
		.sel(Smux1),
		.out(outMux1));

	mux_4_input #(.WORD_LENGTH (24)) mux2(
		.in1(), // what goes here ??
		.in2(), 
		.in3(), 
		.in4(), // what to put here to do nothing??
		.sel(Smux2),
		.out(outMux2));

	// what about combinational unit ??

	register #(.size(16)) Temp( //is the size ok??
		.clock(clk),
		.rst(rst),
		.enable(Temp_en),
		.regIn(out_combinational),
		.regOut(out_Temp));

	assign W_data = {out_Temp, out_combinational}; //is the order ok??