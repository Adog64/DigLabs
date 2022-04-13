module DisplayDriver( input [3:0] valueIn,
			input [1:0] displaySelect,
			output [6:0] display0,
			output [6:0] display1,
			output [6:0] display2,
			output [6:0] display3);
			
			wire [3:0] nigel0, nigel1, nigel2, nigel3;
			
			Demux1x4To4x4 demux1 (valueIn, displaySelect, nigel0, nigel1, nigel2, nigel3);
			HexTo7Seg rick0 (nigel0, display0);
			HexTo7Seg rick1 (nigel1, display1);
			HexTo7Seg rick2 (nigel2, display2);
			HexTo7Seg rick3 (nigel3, display3);

endmodule