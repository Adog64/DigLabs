module stopwatch(input MAX10_CLK1_50, input [1:0]KEY, output [7:0]HEX3, output [7:0]HEX2, output [7:0]HEX1, output [7:0]HEX0);
    reg [3:0]count0;
    reg [3:0]count1;
    reg [3:0]count2;
    reg [3:0]count3;

    reg [32:0]scaler;

    reg running = 1;
    wire start_stop;
	
    dec_to_7_seg hundreths (.clk(MAX10_CLK1_50), .dec(count0), .dot(0), .segs(HEX0));
    dec_to_7_seg tenths    (.clk(MAX10_CLK1_50), .dec(count1), .dot(0), .segs(HEX1));
    dec_to_7_seg ones      (.clk(MAX10_CLK1_50), .dec(count2), .dot(1), .segs(HEX2));
    dec_to_7_seg tens      (.clk(MAX10_CLK1_50), .dec(count3), .dot(0), .segs(HEX3));

    t_flip_flop toggle_run (.clk(MAX10_CLK1_50), .t(KEY[0]), .q(start_stop));
    always @(posedge MAX10_CLK1_50) begin
        running <= start_stop;
        if (~KEY[1] & ~running) begin
            scaler <= 0;
            count0 <= 0;
            count1 <= 0;
            count2 <= 0;
            count3 <= 0;
        end
        if (running) begin
            if (scaler < 500000) begin // 500,000 for FPGA, 10 for tb
                scaler <= scaler + 1;
            end else begin
                scaler <= 0;
                if (count0 < 9) begin
                    count0 <= count0 + 1;
                end else begin
                    count0 <= 0;
                    if (count1 < 9) begin
                        count1 <= count1 + 1;
                    end else begin
                        count1 <= 0;
                        if (count2 < 9) begin
                            count2 <= count2 + 1;
                        end else begin
                            count2 <= 0;
                            if (count3 < 5) begin
                                count3 <= count3 + 1;
                            end else begin
                                count3 <= 0;
                            end
                        end
                    end
                end
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
        else if (~t & ~hit) begin
            q <= ~q;
            hit <= 1;
        end else if (t)
            hit <= 0;
    end  
endmodule