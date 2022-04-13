module Demux1x4To4x4( input [3:0] In,
				input [1:0] select,
				output reg [3:0] Out0,
				output reg [3:0] Out1,
				output reg [3:0] Out2,
				output reg [3:0] Out3);
				
	always @(In or select) begin
		case (select)
			2'b00 : Out0 <= In;
			2'b01 : Out1 <= In;
			2'b10 : Out2 <= In;
			2'b11 : Out3 <= In;
		endcase
	end

endmodule