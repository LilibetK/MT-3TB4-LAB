module lab1part3 (input[9:0]SW,input[3:0]KEY,input clk_50,output[6:0] HEX0);
	reg [6:0] reg_LEDs;
	assign HEX0[6:0]=reg_LEDs[6:0];
	wire [3:0] countFour; 		// saves the number of key 3 pressed
	wire [29:0] countFif;      // saves the number of  CLOCK_50 count
	
	counterF count1(.reset(KEY[0]), .enable(KEY[3]), .result(countFour));// call the module
	counter5 count2(.clk(clk_50), .reset_n(KEY[0]),.result_50(countFif));// call the module
	
	
	always@(*)
	begin
		case(SW[9:8])
		
			//SW8 and SW9 both on,HEX shows off.
			2'b11: reg_LEDs[6:0]=7'b1111111;
			
			//SW8 &SW9 both off, show seven segement
			2'b00:
					begin
					reg_LEDs[0]= ~(((~SW[3])&SW[1]) | ((~SW[2])&(~SW[1])&(~SW[0])) | (SW[3]&SW[2]&(~SW[0])) | ((~SW[3])&SW[2]&SW[0]) | (SW[3]&(~SW[2])&(~SW[1])));
					reg_LEDs[1]= ~((~SW[2]) | ((~SW[3])&(~SW[1])&(~SW[0])) | ((~SW[3])&SW[1]&SW[0]) | (SW[3]&(~SW[1])&SW[0]) | (SW[3]&SW[1]&(~SW[0])));						
						/*Output 0= A’C +B’C’D’+ ABD’+A’BD+AB’C’
						  Output 1= B’+A’C’D’ + A’CD+ AC'D+ACD’*/
						
						case (SW[3:0])
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

						endcase
					end
					
			//SW8 is on, SW9 is off,press KEY[3] to count numbers
			2'b01:
					begin		
						case (countFour[3:0])
							4'b0000: reg_LEDs[6:0]=7'b1000000; //decimal 0
							4'b0001: reg_LEDs[6:0]=7'b1111001; //decimal 1
							4'b0010: reg_LEDs[6:0]=7'b0100100; //decimal 2
							4'b0011: reg_LEDs[6:0]=7'b0110000; //decimal 3
							4'b0100: reg_LEDs[6:0]=7'b0011001; //decimal 4
							4'b0101: reg_LEDs[6:0]=7'b0010010; //decimal 5
							4'b0110: reg_LEDs[6:0]=7'b0000010; //decimal 6
							4'b0111: reg_LEDs[6:0]=7'b1111000; //decimal 7
							4'b1000: reg_LEDs[6:0]=7'b0000000; //decimal 8
							4'b1001: reg_LEDs[6:0]=7'b0010000; //decimal 9
							4'b1010: reg_LEDs[6:0]=7'b0010001; //decimal y
							4'b1011: reg_LEDs[6:0]=7'b1111001; //decimal i
							4'b1100: reg_LEDs[6:0]=7'b0000110; //decimal m
							4'b1101: reg_LEDs[6:0]=7'b1111001; //decimal i
							4'b1110: reg_LEDs[6:0]=7'b1001000; //decimal n
							4'b1111: reg_LEDs[6:0]=7'b1111111; //decimal OFF
                        
						endcase
					end
					
			//SW8 is on, SW9 is off,press KEY[3] to count numbers
			2'b10:
					begin
						case (countFif[29:26])//only use most significant four bits which is 29:26
							4'b0000: reg_LEDs[6:0]=7'b1000000; //decimal 0
							4'b0001: reg_LEDs[6:0]=7'b1111001; //decimal 1
							4'b0010: reg_LEDs[6:0]=7'b0100100; //decimal 2
							4'b0011: reg_LEDs[6:0]=7'b0110000; //decimal 3
							4'b0100: reg_LEDs[6:0]=7'b0011001; //decimal 4
							4'b0101: reg_LEDs[6:0]=7'b0010010; //decimal 5
							4'b0110: reg_LEDs[6:0]=7'b0000010; //decimal 6
							4'b0111: reg_LEDs[6:0]=7'b1111000; //decimal 7
							4'b1000: reg_LEDs[6:0]=7'b0000000; //decimal 8
							4'b1001: reg_LEDs[6:0]=7'b0010000; //decimal 9
							4'b1010: reg_LEDs[6:0]=7'b0010001; //decimal y
							4'b1011: reg_LEDs[6:0]=7'b1111001; //decimal i
							4'b1100: reg_LEDs[6:0]=7'b0000110; //decimal m
							4'b1101: reg_LEDs[6:0]=7'b1111001; //decimal i
							4'b1110: reg_LEDs[6:0]=7'b1001000; //decimal n
							4'b1111: reg_LEDs[6:0]=7'b1111111; //decimal OFF
                    
						endcase
					end
					
		endcase
		end
endmodule





module counterF(input reset,enable,output reg[3:0]result);//module the counting for Key3
	always @(posedge enable,negedge reset)begin
		if (~reset)//reset
			result<=4'b0;
		else if (enable)//if press,adding up
			result<=result+1'b1;
		end
endmodule


module counter5(input clk, reset_n, output reg[29:0]result_50);//module the counting for clock_50
	parameter WIDTH=4;
	//2’s power of 26 is 67,108,864.
	// that is 1 second (2^26/50e6 = 1.34), if count is using CLOCK 50
	always@(posedge clk, negedge reset_n) begin
		if(~reset_n)begin//reset
			result_50<=30'b0;
		end else begin
			result_50<=result_50+30'b1;
		end	
		end
endmodule
