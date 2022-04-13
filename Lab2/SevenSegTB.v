module SevenSegTB();
	reg [3:0] hexIn;
	wire [6:0] sevenSegOut;
	
	HexTo7Seg dut (hexIn, sevenSegOut);

	initial
		hexIn <= 4'b0;
	
	always begin
		#10 
		hexIn <= hexIn + 4'b0001;
	end
	
	initial begin
		#160 $stop;
	end
endmodule
