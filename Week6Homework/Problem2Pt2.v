// Design Homework Week 6 Problem 2
// This module is used for showing a 2 bit number on a 7 seg (inverted logic)

module Problem2_binary (input clk,
								input rst,
								input inc,
								input dec,
								output [6:0] hexout);
							
	reg [6:0] value;
	assign hexout = value;


	reg [1:0] state;
	// binary encoding for states
	local param[1:0] s0 = 2'b00,
						  s1 = 2'b01,
						  s2 = 2'b10,
						  s3 = 2'b11;
						  
	// encodings for seven-seg outputs
	local param [6:0] disp0 = 7'b1000000,
							disp1 = 7'b1111001,
							disp2 = 7'b0100100,
							disp3 = 7'b0110000;

	always @ (posedge clk)
	begin
		if (rst)
		begin
			state <= s0;
			value <= disp0;
		end
		
		else
		begin
			case(state)
			s0:	begin
						value <= disp0;
						if (inc)
							state <= s1;
						else if (dec)
							state <= s3;
						else
							state <= state;
						end
			s1:	begin
						value <= disp1;
						if (inc)
							state <= s2;
						else if (dec)
							state <= s0;
						else
							state <= state;
						end
			s2:	begin
						value <= disp2;
						if (inc)
							state <= s3;
						else if (dec)
							state <= s1;
						else
							state <= state;
						end
			s3:	begin
						value <= disp3;
						if (inc)
							state <= s0;
						else if (dec)
							state <= s2;
						else
							state <= state;
						end
			endcase
			
		end

	end

endmodule




	Testbench
	// Design Problem Week 6 Problem 2 Testbench
	// Russell Trafford
	// This testbench will generate clk, rst, inc, and dec, while monitoring hexout

module Problem2_binary_tb();

	reg clk, rst, inc, dec;
	wire [6:0] hexout;

	Problem2_binary dut (clk, rst, inc, dec, hexout);

	localparam CLK_PERIOD = 4;

	//Generate Clock
	always begin
		clk = 0;
		#(CLK_PERIOD / 4);
		clk = 1;
		#(CLK_PERIOD / 4);
	end

	initial begin
		rst = 1;
		inc = 0;
		dec = 0;
		#(CLK_PERIOD * 2) // Test the reset line
		rst = 0;
		#(CLK_PERIOD * 2) // Testing that system does not move forward
		inc = 1;
		#(CLK_PERIOD * 4) // See if we can cycle through the machine forwards
		inc = 0;
		dec = 1;
		#(CLK_PERIOD * 4) // See if we can cycle through the machine backwards
		inc = 1;
		#(CLK_PERIOD * 2) // Move forward  states and then see if system stays still
		inc = 0;
		#(CLK_PERIOD * 2) // Check Reset from a non-zero state
		rst = 1;
		#(CLK_PERIOD * 2) 
		$stop;
	end
endmodule

