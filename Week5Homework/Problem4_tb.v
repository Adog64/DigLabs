module Problem4_tb (
	//define inputs and outputs, do we need these for a testbench?
	);

//define inputs to the dut
reg clk_tb, rst_tb, x_tb;


//define outputs from the dut
wire z_tb;
	localparam CLK_PERIOD = 20; // define a parameter called clock that we can change once to impact code

	//instantiate module as dut
	FSM FSM_tb(clk_tb, rst_tb, x_tb, z_tb);
	//generate a clock signal
	always begin

	clk_tb = 0;

	#(CLK_PERIOD / 2);

	clk_tb = 1;

	#(CLK_PERIOD / 2);

	end
	//develop test sequence
	initial begin
	rst_tb = 1;
	x_tb = 0;
	#CLK_PERIOD rst_tb = 0;

	#CLK_PERIOD x_tb = 1;

	#CLK_PERIOD x_tb = 0;

	end
endmodule