module stopwatch_tb();
    reg clk = 0;
	reg [1:0]start_stop_rst = 2'b00;

	wire [7:0]h0;
	wire [7:0]h1;
	wire [7:0]h2;
	wire [7:0]h3;

	// timing junk
    stopwatch st (.MAX10_CLK1_50(clk), .KEY(start_stop_rst), .HEX0(h0), .HEX1(h1), .HEX2(h2), .HEX3(h3));

	// wiggly pulse
	always begin
		#5 clk = ~clk;
    end

	// state testing
	initial begin
		#1000 start_stop_rst = 2'b01; // stop
		#1000 start_stop_rst = 2'b00;
		#1000 start_stop_rst = 2'b10; // resume
		#1000 start_stop_rst = 2'b00;
		#1000 start_stop_rst = 2'b10; // stop
		#1000 start_stop_rst = 2'b00;
		#1000 start_stop_rst = 2'b01; // reset
		#1000 start_stop_rst = 2'b10; // resume
		#1000 start_stop_rst = 2'b00;
    	#150000 $stop;
    end
endmodule