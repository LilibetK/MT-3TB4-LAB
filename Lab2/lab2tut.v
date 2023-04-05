module lab2tut (input CLOCK_50, input [2:0] KEY, output [6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
	wire clk_en;
	wire [19:0] ms;
	wire [3:0] digit0,digit1,digit2,digit3,digit4,digit5;
	
	clock_divider #(.factor(100000)) (.clock(CLOCK_50), .Reset_n(KEY[0]), .clk_ms(clk_en));
	counter(.clk(clk_en), .reset_n(KEY[0]), .start_n(KEY[1]), .stop_n(KEY[2]), .ms_count(ms));
	hex_to_bcd_converter(CLOCK_50, KEY[0], ms, digit0,digit1,digit2,digit3, digit4,digit5);	

	seven_seg_decoder decoder0(digit0,HEX0);
	seven_seg_decoder decoder1(digit1,HEX1);
	seven_seg_decoder decoder2(digit2,HEX2);
	seven_seg_decoder decoder3(digit3,HEX3);
	seven_seg_decoder decoder4(digit4,HEX4);
	seven_seg_decoder decoder5(digit5,HEX5);
	
endmodule

	

module clock_divider (input clock, Reset_n, output reg clk_ms);
	parameter factor=100000; //50000; // 32'h000061a7;
	reg [31:0] countQ;
	
	always @ (posedge clock, negedge Reset_n) begin
	if (!Reset_n)
			countQ[31:0] <= 32'b0;
	else if(countQ == factor -1)begin
		countQ <= 32'b0;
	end
		else begin
			if (countQ<factor/2)begin
				clk_ms <= 1'b1;
				countQ <= countQ +32'b1;
				
			end else if(countQ<factor) begin
				clk_ms <= 1'b0;
				countQ <= countQ +32'b1;
			end else begin//countQ==factor 
				countQ[31:0] <= 32'b0;
				end
		end
	end
endmodule 


module counter(input clk, reset_n, start_n, stop_n, output reg [19:0] ms_count);
	
	reg state = 1'b0;
	
	always@(posedge clk, negedge reset_n) begin
		//set counter to be 0 when reset button pressed
		if (~reset_n) begin
			ms_count <= 20'b0;
		//if stop button pressed, go state0
		end else if (~stop_n) begin
			state <= 1'b0;
		//if start/resume button pressed, go state1
		end else if  (~start_n)begin
			state <= 1'b1;
			end
		else if(state == 1'b1)begin
		
			ms_count <= ms_count + 1'b1; 		
		end
		
	end
endmodule



module hex_to_bcd_converter(input wire clk, reset, input wire [19:0] hex_number, output [3:0] bcd_digit_0,
	bcd_digit_1,bcd_digit_2,bcd_digit_3,bcd_digit_4,bcd_digit_5);
	integer i,k;
	wire [19:0] hex_number1;
	reg [3:0] bcd_digit [5:0];
	assign hex_number1=hex_number[19:0];
	
	assign bcd_digit_0 = bcd_digit[0];
	assign bcd_digit_1 = bcd_digit[1];
	assign bcd_digit_2 = bcd_digit[2];
	assign bcd_digit_3 = bcd_digit[3];
	assign bcd_digit_4 = bcd_digit[4];
	assign bcd_digit_5 = bcd_digit[5];
	
	always @ (*)begin
		//set all 6 digits to 0
		bcd_digit[0] = 4'b0000;
		bcd_digit[1] = 4'b0000;
		bcd_digit[2] = 4'b0000;
		bcd_digit[3] = 4'b0000;
		bcd_digit[4] = 4'b0000;
		bcd_digit[5] = 4'b0000;
		
		//shift 20 times
		for (i=19;i>=0;i=i-1)begin
			bcd_digit[0] = bcd_digit[0] + hex_number1[i];
			//check all 6 BCD tetrads, if >=5,add3
			for (k=5;k>=0;k=k-1)begin
				if (bcd_digit[k] >= 5)
					bcd_digit[k] = bcd_digit[k] + 4'd3;
			end
			
			//shift one bit of BIN/HEX left
			//for the first 5 tetrads
			for (k=5;k>=1;k=k-1)begin
				bcd_digit[k] = bcd_digit[k] << 1;
				bcd_digit[k][0] = bcd_digit[k-1][3];
			end
			
			//shift one bit of BIN/HEX left
			//for the last tetrads
			bcd_digit[0] = bcd_digit[0] << 1;
		end
			bcd_digit[0] = bcd_digit[0] + hex_number1[0];

	end
endmodule

	




module seven_seg_decoder (input [3:0] SW, output [6:0] HEX0);
	reg[6:0] reg_LEDs;

	assign HEX0[0]= ~(((~SW[3])&SW[1]) | ((~SW[2])&(~SW[1])&(~SW[0])) | (SW[3]&SW[2]&(~SW[0])) | ((~SW[3])&SW[2]&SW[0]) | (SW[3]&(~SW[2])&(~SW[1])));/* expression for segment 0 */

	assign HEX0[1]= ~((~SW[2]) | ((~SW[3])&(~SW[1])&(~SW[0])) | ((~SW[3])&SW[1]&SW[0]) | (SW[3]&(~SW[1])&SW[0]) | (SW[3]&SW[1]&(~SW[0])));/* expression for segment 1 */
	
	/*Output 0= A’C +B’C’D’+ ABD’+A’BD+AB’C’
	  Output 1= B’+A’C’D’ + A’CD+ AC'D+ACD’*/
	
	assign HEX0[6:2]=reg_LEDs[6:2];
	
	always @(*)begin
		case (SW)
			4'b0000: reg_LEDs[6:2]=5'b10000; //7’b1000000 decimal 0
			4'b0001: reg_LEDs[6:2]=5'b11110; //7’b1111001 decimal 1
			4'b0010: reg_LEDs[6:2]=5'b01001; //7’b0100100 decimal 2
			4'b0011: reg_LEDs[6:2]=5'b01100; //7’b0110000 decimal 3
			4'b0100: reg_LEDs[6:2]=5'b00110; //7’b0011001 decimal 4
			4'b0101: reg_LEDs[6:2]=5'b00100; //7’b0010010 decimal 5
			4'b0110: reg_LEDs[6:2]=5'b00000; //7’b0000010 decimal 6
			4'b0111: reg_LEDs[6:2]=5'b11110; //7’b1111000 decimal 7
			4'b1000: reg_LEDs[6:2]=5'b00000; //7’b0000000 decimal 8
			4'b1001: reg_LEDs[6:2]=5'b00100; //7’b0010000 decimal 9
			4'b1010: reg_LEDs[6:2]=5'b00100; //7’b0010001 decimal y
			4'b1011: reg_LEDs[6:2]=5'b11110; //7’b1111001 decimal i
			4'b1100: reg_LEDs[6:2]=5'b00001; //7’b0000110 decimal m
			4'b1101: reg_LEDs[6:2]=5'b11110; //7’b1111001 decimal i
			4'b1110: reg_LEDs[6:2]=5'b10010; //7’b1001000 decimal n
			4'b1111: reg_LEDs[6:2]=5'b11111; //7’b1111111 decimal OFF
			default: reg_LEDs[6:2]=5'bx;
			/* finish the case block */
		endcase
		
	end
	
endmodule 