module SerialAddressChecker(input clk, input rst, input bit, output selected)

// desired bits 0b00111111
// 15 states (0 - 14)

reg state[3:0];

// initial state = 7'0b0000000;

always @ (posedge clk) begin
	if (rst) begin
		state <= 4'b0000;
	end else begin
	case (state)
		0000: begin // in state 0
			if (bit) begin
				state <= 4'b0010;
			end else begin
				state <= 4'b0001;
			end
			selected <= 0b0;
		end
		0001: begin	// in state 1
			if (bit) begin
				state <= 4'b0100;
			end else begin
				state <= 4'b0011;
			end
			selected <= 0b0;
		end
		0010: begin	// in state 2
			state <= 4'b0100;
			selected <= 0b0;
		end
		0011: begin	// in state 3
			if (bit) begin
				state <= 4'b0101;
			end else begin
				state <= 4'b0110;
			end
			selected <= 0b0;
		end
		0100: begin	// in state 4
			state <= 0'b0110;
			selected <= 0b0;
		end
		0101: begin	// in state 5
			if (bit) begin
				state <= 4'b0111;
			end else begin
				state <= 4'b1000;
			end
			selected <= 0b0;
		end
		0110: begin	// in state 6
			state <= 4'b1000;
			selected <= 0b0;
		end
		0111: begin	// in state 7
			if (bit) begin
				state <= 4'b1001;
			end else begin
				state <= 4'b1010;
			end
			selected <= 0b0;
		end
		1000: begin	// in state 8
			state <= 4'b1010;
			selected <= 0b0;
		end
		1001: begin	// in state 9
			if (bit) begin
				state <= 4'b1011;
			end else begin
				state <= 4'b1110;
			end
			selected <= 0b0;
		end
		1010: begin	// in state 10
			state <= 4'b1100;
			selected <= 0b0;
		end
		1011: begin	// in state 11
			if (bit) begin
				state <= 4'b1101;
			end else begin
				state <= 4'b1110;
			end
			selected <= 0b0;
		end
		1100: begin	// in state 12
			state <= 4'b1110;
			selected <= 0b0;
		end
		1101: begin	// in state 13
			state <= 4'b0000;
			selected <= 0b1;
		end
		1110: begin	// in state 14
			state <= 4'b0000;
			selected <= 0b0;
		end
	end`
endmodule