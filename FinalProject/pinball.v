module pinball(input [1:0]KEY, input MAX10_CLK1_50, output [7:0]HEX0, output [7:0]HEX1, output [7:0]HEX2, output [7:0]HEX3, output [7:0]HEX4);
    reg [15:0]score = 0;
    
    wire [3:0]tenthous;
    wire [3:0]thous;
    wire [3:0]huns;
    wire [3:0]tens;
    wire [3:0]ones;

    wire tick;
    wire new_game;
    wire bumber_hit;
    // convert score to BCD
    BCD score_con(.bin(score), .tth(tenthous), .tho(thous), .hun(huns), .ten(tens), .one(ones));

    // seven seg digit displays
    dec_to_7_seg (.clk(MAX10_CLK1_50), .dec(tenthous), .dot(0), .segs(HEX4));
    dec_to_7_seg (.clk(MAX10_CLK1_50), .dec(thous), .dot(0), .segs(HEX3));
    dec_to_7_seg (.clk(MAX10_CLK1_50), .dec(huns), .dot(0), .segs(HEX2));
    dec_to_7_seg (.clk(MAX10_CLK1_50), .dec(tens), .dot(0), .segs(HEX1));
    dec_to_7_seg (.clk(MAX10_CLK1_50), .dec(ones), .dot(0), .segs(HEX0));

    re_monostable reset_pulser (.clk(MAX10_CLK1_50), .line_in(KEY[1]), .tick(new_game));
    re_monostable scoring (.clk(MAX10_CLK1_50), .line_in(KEY[0]), .tick(bumber_hit));

    always @(posedge MAX10_CLK1_50) begin
        if (new_game)
            score = 0;
        if (bumber_hit)
            score = score + 100;
    end
endmodule

// fonky 16-bit binary to BCD algorithm
module BCD(input [15:0]bin, output reg [3:0]tth, output reg [3:0]tho, output reg [3:0]hun, output reg [3:0]ten, output reg [3:0]one);
    integer i;
    always @(bin) begin
        // decimal place values
        tth = 4'b0;
        tho = 4'b0;
        hun = 4'b0;
        ten = 4'b0;
        one = 4'b0;

        for (i = 15; i>=0; i=i-1) begin
            // add 3 if greater than or equal to 5
            if (tth >= 5)
                tth = tth + 3;
            if (tho >= 5)
                tho = tho + 3;
            if (hun >= 5)
                hun = hun + 3;
            if (ten >= 5)
                ten = ten + 3;
            if (one >= 5)
                one = one + 3;
            
            // bit shift magic
            tth = tth << 1;
            tth[0] = tho[3];
            tho = tho << 1;
            tho[0] = hun[3];
            hun = hun << 1;
            hun[0] = ten[3];
            ten = ten << 1;
            ten[0] = one[3];
            one = one << 1;
            one[0] = bin[i];
        end
    end
endmodule

module dec_to_7_seg(clk, dec, dot, segs);
    input clk;
    input [3:0]dec;
    input dot;
    output reg [7:0]segs = 8'b1111_1111;

    always @(clk) begin
        case (dec)
            0: begin
                segs <= 8'b1100_0000;
            end
            1: begin
                segs <= 8'b1111_1001;
            end
            2: begin
                segs <= 8'b1010_0100;
            end
            3: begin
                segs <= 8'b1011_0000;
            end
            4: begin
                segs <= 8'b1001_1001;
            end
            5: begin
                segs <= 8'b1001_0010;
            end
            6: begin
                segs <= 8'b1000_0010;
            end
            7: begin
                segs <= 8'b1111_1000;
            end
            8: begin
                segs <= 8'b1000_0000;
            end
            9: begin
                segs <= 8'b1001_0000;
            end
        endcase
        if (dot) begin
            segs[7] <= 0;
        end
    end
endmodule

// send a one tick pulse on the rising edge of the input
module re_monostable(input clk, input line_in, output reg tick);
    reg clicked = 0;
    always @(posedge clk) begin
        // set wire to 0
        tick = 0;
        // turn on wire when pressed
        if (~line_in & ~clicked) begin
            clicked = 1;
            tick = 1;
        // reset when press is over
        end else if (line_in & clicked)
            clicked = 0;
    end
endmodule

// toggleable signal from pulsed input
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