module HexTo7Seg(hexIn, sevenSegOut);
	
// define inputs and outputs
	
input [3:0] hexIn;
	output [6:0] sevenSegOut;
	wire a, b, c, d;

	// connect our inputs to wires which we can use to make circuits
	assign a = hexIn[3];
	assign b = hexIn[2];
	assign c = hexIn[1]; 
	assign d = hexIn[0];

	// Assign the output ports through the wires connected to the input ports, describing the flow the data should take.
  assign sevenSegOut[0] = ~((~b & ~d) | (~a & c) | (b & c) | (a & ~d) | (a & ~b & ~c) | (~a & b & d));
  assign sevenSegOut[1] = ~((~a & ~b) | (~a & ~c & ~d) | (~a & c & d) | (a & ~c & d) | (~b & ~d));
  assign sevenSegOut[2] = ~((~c & d) | (~a & b) | (a & ~b) | (~a & ~c) | (~a & d));  
  assign sevenSegOut[3] = ~((~c & a) | (a & ~b & d) | (b & ~c & d) | (~a & ~b & ~d) | (~a & ~b & c) | (b & c & ~d));    
  assign sevenSegOut[4] = ~((~b & ~d) | (c & ~d) | (a & b) | (a & c));
  assign sevenSegOut[5] = ~((~a & b & ~c) | (b & ~d) | (~c & ~d) | (a & ~b) | (a & c));
  assign sevenSegOut[6] = ~((~a & b & ~c ) |( ~b & c ) |( a &~b ) |(c & ~d ) |( a & d));

    
endmodule 
