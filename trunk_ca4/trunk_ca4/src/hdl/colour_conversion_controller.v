module colour_conversion_controller(clk, rst, clear, start, Smux1, Smux2, Wrenb, Yen_odd, Uen_odd, Ven_odd,
	Temp_en,Yen_even, Uen_even, Ven_even, Cen, done, end_of_pixel, Roffset, Woffset);

	input clk, rst, start, end_of_pixel;
	parameter [2:0] IDLE = 3'd0, WAIT = 3'd1, READ0 = 3'd2, READ1 = 3'd3, READ2 = 3'd4, 
					READ3 = 3'd5, READ4 = 3'd6, READ5 = 3'd7;

	parameter[19:0] a_third_of_all_pixels = 20'd 38400;
	output reg clear, Smux1, Wrenb, Yen_odd, Uen_odd, Ven_odd,
		Temp_en,Yen_even, Uen_even, Ven_even, Cen;
	output reg [1:0]  Smux2;
	output done;
	output reg [17:0] Roffset, Woffset;
	reg [2:0] ps = 0, ns;

	always @(ps) begin
		{clear, Smux1, Wrenb, Yen_odd, Uen_odd, Ven_odd,
			Temp_en,Yen_even, Uen_even, Ven_even, Cen} = 20'b0;
		Smux2 = 2'b0;
		Roffset = 18'd0;
		Woffset = 18'd0;

		case(ps)
			IDLE:begin		clear = 1'b1; 
				  end
			WAIT:begin
							//do nothing //
				  end	
			READ0:begin		Smux1 = 1'b1; Smux2 = 2'b00; 
							Yen_odd = 1'b1; Wrenb = 1'b1; Woffset = 18'd2;  // 1
				  end
			READ1:begin		Smux1 = 1'b1; Smux2 = 2'b01;
							Uen_odd = 1'b1; Temp_en = 1'b1; Roffset = a_third_of_all_pixels;
				  end
			READ2:begin		Smux1 = 1'b1; Smux2 = 2'b10;
							Ven_odd = 1'b1; Wrenb = 1'b1; Roffset = a_third_of_all_pixels * 2; Woffset = 18'd1; // 2
				  end
			READ3:begin		Smux1 = 1'b0; Smux2 = 2'b00;
			 				Yen_even = 1'b1; Temp_en = 1'b1;
				  end
			READ4:begin		Smux1 = 1'b0; Smux2 = 2'b01;
							Uen_even = 1'b1; Wrenb = 1'b1; Roffset = a_third_of_all_pixels;  // 0 3
				  end
			READ5:begin		Smux1 = 1'b0; Smux2 = 2'b10;
							Ven_even = 1'b1; Temp_en = 1'b1; Cen = 1'b1; Roffset = a_third_of_all_pixels * 2;
				  end
			// default:	
		endcase

	end

	always @(ps) begin
		case(ps)
			IDLE:	ns = WAIT; 
			WAIT: 	ns = READ0;
			READ0:	ns = READ1;
			READ1:	ns = READ2;
			READ2:	ns = READ3;
			READ3:  ns = READ4;
			READ4:  ns = READ5;
			READ5:	ns = READ0;
			default: ps = ps;
		endcase
	end
	assign done = end_of_pixel == 1'b1 ? 1 : 0;
	always @(posedge clk or posedge rst) begin
		if (rst) begin
			ps <= IDLE;
		end
		else ps <= ns;
	end


endmodule
