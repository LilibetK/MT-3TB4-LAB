module multi3_1 (input [2:0]a,b,c,input [1:0]s,output reg [2:0]out);
	always @(*)begin
		case(s)
			2'b00: out<=a;
			2'b01: out<=b;
			2'b10: out<=c;
			2'b11: out<=3'bx;//catch accident case
		endcase
	end
endmodule
