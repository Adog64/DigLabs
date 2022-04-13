module problem4FSM (
	// list your inputs and outputs
      input clk, rst;
      input x;
      output reg z;
	);

	// create a local param to link your states to a number
	localparam [1:0] B0 = 0;
						  B1 = 0;
						  B2 = 0;
						  B3 = 0;
						  B4 = 1;

	// create the register which will hold the current state we are in
	reg[1:0] State;

	// build up your case statement on what to do in each state and how to transition between them
	always @(posedge clk) begin
		if (rst) begin
			// what should your system do if reset?

					State = B0;
		end
		else begin
		// state transitions

      case (State) begin
            B0: begin
               if (!x) begin
                  probelm4_State = B0;
               end
               else if (x) begin
                  State = B1;
               end
            end
				
            B1: begin
               if (!x) begin
                  State = B0;
               end
               else if (x) begin
                  State = B2;
               end 
            end  
				
            B2: begin
               if (x) begin
                  State = B2;
               end
               else if (!x) begin
                  State = B3;
               end
            end 
				
            B3: begin
               if (!x) begin
                  State = B0;
               end
               else if (x) begin
                  State = B4;
               end
            end 
				
           B4: begin
               if (!x) begin
                  State = B0;
               end
               else if (x) begin
                  State = B2;
               end
            end
				
           default: begin
               State = B0;
           end

       endcase

                 	end
	
	// state actions, define what should happen in each state
      case (State)
          B0: begin
             z = 0;
          end     

          B1: begin
             z = 0;
          end
			 
          B2: begin
             z = 0;
          end 
			 
          B3: begin
             z = 0;
          end 

          B4: begin
             z = 1;
          end
      endcase          
	end
endmodule 