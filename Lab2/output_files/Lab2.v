module Lab2 (input [9:0] SW, output[6:0] HEX0, HEX1, HEX2, HEX3);

	DisplayDriver dd (SW[3:0], SW[9:8], HEX0[6:0], HEX1[6:0], HEX2[6:0], HEX3[6:0]);

endmodule 