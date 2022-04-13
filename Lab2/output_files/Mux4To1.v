module mux4to1(in, select, out);
	input [3:0] in;
	input [1:0] select;
	output reg out;
	
	always @(in or select) begin
		case (select)
			2'b00 : out <= in[0];
			2'b01 : out <= in[1];
			2'b10 : out <= in[2];
			2'b11 : out <= in[3];
		endcase
	end
	
endmodule