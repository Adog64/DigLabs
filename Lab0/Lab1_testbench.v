module Lab1_testbench();
	reg [7:0] switch;
	wire [7:0] hex;
	
	Lab1 dut (hex, switch);

	initial
		switch <= 7'b0;
	
	always begin
		#10 
		switch <= switch + 7'b0000001;
	end
	
	initial begin
		#1500 $stop;
	end
endmodule
