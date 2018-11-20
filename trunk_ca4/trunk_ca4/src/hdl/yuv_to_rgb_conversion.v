`default_nettype none
module yuv_to_rgb_conversion#(
	parameter ADDR_REORDER_PIXEL = 0,
	parameter ADDR_ORDER_PIXEL = 115200,
	parameter W = 320,
	parameter H = 240,
	parameter DW = 16,
	parameter AW = 18)
(
	input wire clk,
	input wire reset,
	input wire start, // 
	output wire done,
	// *********** SRAM Interface Signals ****************************
	// Read-only port
	output wire [AW-1:0]	raddr,
	input wire	[DW-1:0]	rdata,
	// Write-only port
	output wire [AW-1:0]	waddr,
	output wire [DW-1:0]	wdata,
	output wire 			wr_enable
);



wire Smux1, Smux2, Yen_odd, Uen_odd, Ven_odd, Yen_even, Uen_even, Ven_even, clear;
wire Cen, end_of_pixel, Temp_en;
	
	colour_conversion_controller c(
	.clk(clk), 
	.rst(reset), 
	.clear(clear), 
	.start(start), 
	.Smux1(Smux1), 
	.Smux2(Smux2), 
	.Wrenb(wr_enable), 
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
	.R_data(rdata), 
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
	.W_data(wdata)
	);


	
endmodule

