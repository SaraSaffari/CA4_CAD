module colour_conversion(clk, rst, clear, start, done, Wrenb, W_data, R_data);


input wire clk, rst, start, clear;
input wire [15:0] R_data;
output reg done, Wrenb;
output reg [15:0] W_data;

wire Smux1, Smux2, Yen_odd, Uen_odd, Ven_odd, Yen_even, Uen_even, Ven_even;
wire Cen, end_of_pixel, Temp_en;

colour_conversion_controller c(
	.clk(clk), 
	.rst(rst), 
	.clear(clear), 
	.start(start), 
	.Smux1(Smux1), 
	.Smux2(Smux2), 
	.Wrenb(Wrenb), 
	.Yen_odd(Yen_odd), 
	.Uen_odd(Uen_odd), 
	.Ven_odd(Ven_odd), 
	.Temp_en(Temp_en), 
	.Yen_even(Yen_even), 
	.Uen_even(Uen_even), 
	.Ven_even(Ven_even), 
	.Cen(Cen), 
	.done(done), 
	.end_of_pixel(end_of_pixel)
	);

colour_conversion_datapath	D(
	.clk(clk), 
	.rst(clear), 
	.R_data(R_data), 
	.Yen_odd(Yen_odd), 
	.Uen_odd(Uen_odd), 
	.Ven_odd(Ven_odd), 
	.Yen_even(Yen_even), 
	.Uen_even(Uen_even), 
	.Ven_even(Ven_even), 
	.Smux1(Smux1), 
	.Smux2(Smux2), 
	.Cen(Cen), 
	.Temp_en(Temp_en), 
	.end_of_pixel(end_of_pixel), 
	.W_data(W_data)
	);


endmodule 