module stopwatch(input MAX10_CLK1_50, input KEY0, input KEY1, output [7:0]HEX3, output [7:0]HEX2, output [7:0]HEX1, output [7:0]HEX0);
    reg running = 1;
    wire started;
    wire [3:0]rollover;

    wire tick;
    wire [7:0]hms;
    wire [7:0]tms;
    wire [7:0]s;
    wire [7:0]ts;
    
    clk_scaler scaler (.clk(MAX10_CLK1_50), .factor(100000), .tick(tick));
    count_0_to_9 countTMS (.clk(MAX10_CLK1_50), .rst(0), .tick(tick),        .enable(1), .val(tms), .rollover(rollover[0]));
    count_0_to_9 countHMS (.clk(MAX10_CLK1_50), .rst(0), .tick(rollover[0]), .enable(1), .val(hms), .rollover(rollover[1]));
    count_0_to_9 countS   (.clk(MAX10_CLK1_50), .rst(0), .tick(rollover[1]), .enable(1), .val(s),   .rollover(rollover[2]));
    count_0_to_9 countTS  (.clk(MAX10_CLK1_50), .rst(0), .tick(rollover[2]), .enable(1), .val(ts),  .rollover(rollover[3]));
    
    dec_to_7_seg tens      (.clk(MAX10_CLK1_50), .dec(ts),  .dot(0), .segs(HEX3));
    dec_to_7_seg ones      (.clk(MAX10_CLK1_50), .dec(s),   .dot(1), .segs(HEX2));
    dec_to_7_seg tenths    (.clk(MAX10_CLK1_50), .dec(hms), .dot(0), .segs(HEX1));
    dec_to_7_seg hundreths (.clk(MAX10_CLK1_50), .dec(tms), .dot(0), .segs(HEX0));

    t_flip_flop start_stop (.clk(MAX10_CLK1_50), .rst(KEY1), .t(KEY0), .q(started));

    always @(MAX10_CLK1_50) begin
        if (KEY1) begin
            running <= 1;
        end else begin
            running <= 1;
        end
    end
endmodule

module count_0_to_9(input clk, input rst, input tick, input enable, output reg [3:0]val, output reg rollover);
    reg top = 0;
    always @(clk) begin
        rollover <= top;
        top <= 0;
        if (rst) begin
            val <= 4'b0000;
            top <= 0;
        end else if (tick & enable) begin
            if (val < 9) begin // count up to 9
                val <= val + 1;
                top <= 0;
            end else if (val == 9) begin // reset to 0 and set rollover flag
                val <= 0;
                top <= 1;
            end
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

module clk_scaler(input clk, input [31:0]factor, output reg tick);
    reg [31:0]count;
    always @(clk) begin
        if (count < factor) begin
            count <= count + 1;
        end else begin
            count <= 0;
            tick <= ~tick;
        end
    end
endmodule