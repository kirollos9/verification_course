module segment_LED_display(hexa, clk, a, b, c, d, e, f, g);
	input [3:0] hexa;
	input clk;
	output reg a,b,c,d,e,f,g;

	reg [6:0] display_out;

	always @(*) begin
		case(hexa)
			4'h0 : display_out = 7'b111_1110;
			4'h1 : display_out = 7'b011_0000;
			4'h2 : display_out = 7'b110_1101;
			4'h3 : display_out = 7'b111_1001;
			4'h4 : display_out = 7'b011_0011;
			4'h5 : display_out = 7'b101_1011;
			4'h6 : display_out = 7'b101_1111;
			4'h7 : display_out = 7'b111_0000;
			4'h8 : display_out = 7'b111_1111;
			4'h9 : display_out = 7'b111_1011;
			4'hA : display_out = 7'b111_0111;
			4'hB : display_out = 7'b001_1111;
			4'hC : display_out = 7'b100_1110;
			4'hD : display_out = 7'b011_1101;
			4'hE : display_out = 7'b100_1111;
			4'hF : display_out = 7'b100_0111;
			default: display_out = 7'b0;
		endcase
	end

	always @(posedge clk) begin
		a <= display_out[6];
		b <= display_out[5];
		c <= display_out[4];
		d <= display_out[3];
		e <= display_out[2];
		f <= display_out[1];
		g <= display_out[0];
	end
endmodule