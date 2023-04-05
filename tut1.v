//module tut1(clock,reset,out,count);
////====INPUT OUTPUT DECLARATIONS =====//
//input clock;
//input reset;
//output out;
//output[7:0]count;
//
////======NET/REG DECLARATIONS =====//
//
////wire [3:0]clock;
//reg[7:0]count=8'b0;
//reg out;
//
//always@(posedge clock,posedge reset)begin
//	if (reset==1'b1)begin
//		count<=1'b0;
//		//out=1;
//	end else if (count ==8'b111)begin
//		out<=1'b1;
//		count<=8'b0;
//	end else begin
//		count<=count+8'b1;
//		out<=1'b0;
//	end
//
//end
//
//endmodule

module tut1(a,b,c,y);
//===
input a,b,c;
output y;
//===
//wire im1;
//wire im2;
//wire im3;
reg y;
//y=a*b+b*c+c*a and,or
//and(im1,a,b);
//and(im2,b,c);
//and(im3,c,a);
//
//or(y,im1,im2,im3);

//assign y=(a&b)|(b&c)|(a&c);
always@(a or b or c)begin
	y=(a&b)|(b&c)|(a&c);


end

endmodule