module combo(MAX10_CLK1_50, SW, KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR);
    input [9:0]SW;
    input [1:0]KEY;
    input MAX10_CLK1_50;
    output [7:0]HEX0;
    output [7:0]HEX1;
    output [7:0]HEX2;
    output [7:0]HEX3;
    output [7:0]HEX4;
    output [7:0]HEX5;
    output reg [9:0]LEDR;

    reg unlocked;
    reg [9:0]combination = 10'b00_0000_0000;

    open_closed oc (.clk(MAX10_CLK1_50), .state(unlocked), .h0(HEX0), .h1(HEX1), .h2(HEX2), .h3(HEX3), .h4(HEX4), .h5(HEX5));
    t_flip_flop tm (.clk(MAX10_CLK1_50), .t(unlocked & KEY[0]), .q(mode));

    always @(MAX10_CLK1_50) begin
        if (mode)
            combination <= SW;
        unlocked <= (SW == combination);
        LEDR <= combination;
    end
endmodule

module open_closed(clk, state, h0, h1, h2, h3, h4, h5);
    input state, clk;
    output reg [7:0]h0;
    output reg [7:0]h1;
    output reg [7:0]h2;
    output reg [7:0]h3;
    output reg [7:0]h4;
    output reg [7:0]h5;
    always @(state) begin
        case (state)
            0: begin
                h5 <= 8'b1100_0110; // C
                h4 <= 8'b1100_0111; // L
                h3 <= 8'b1100_0000; // O
                h2 <= 8'b1001_0010; // S
                h1 <= 8'b1000_0110; // E
                h0 <= 8'b1010_0001; // d
            end
            1: begin
                h5 <= 8'b1100_0000; // O
                h4 <= 8'b1000_1100; // P
                h3 <= 8'b1000_0110; // E
                h2 <= 8'b1010_1011; // n
                h1 <= 8'b1111_1111; // ' '
                h0 <= 8'b1111_1111; // ' '
            end
        endcase
    end
endmodule

module t_flip_flop(input clk, input rst, input t, output reg q);
    reg hit = 0;
    always @ (posedge clk) begin  
        if (rst)
            q <= 0;
        else if (t & ~hit) begin
            q <= ~q;
            hit <= 1;
        end else if (~t)
            hit <= 0;
    end  
endmodule