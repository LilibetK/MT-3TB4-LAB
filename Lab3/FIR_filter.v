module FIR_filter(input clk, reset1, input [15:0]sample, output reg [15:0]result);

parameter N = 70;
reg [15:0] shiftReg[N:0];
wire [15:0] multiRes[N:0];
reg [15:0]add[69:0];
integer j;

reg signed [15:0] coeff [N:0];
always@(*)begin
	coeff[  0]=        -0;
	coeff[  1]=         3;
	coeff[  2]=        -0;
	coeff[  3]=       -11;
	coeff[  4]=         0;
	coeff[  5]=        28;
	coeff[  6]=        -0;
	coeff[  7]=       -58;
	coeff[  8]=         0;
	coeff[  9]=       108;
	coeff[ 10]=        -0;
	coeff[ 11]=      -185;
	coeff[ 12]=         0;
	coeff[ 13]=       293;
	coeff[ 14]=        -0;
	coeff[ 15]=      -437;
	coeff[ 16]=         0;
	coeff[ 17]=       618;
	coeff[ 18]=        -0;
	coeff[ 19]=      -835;
	coeff[ 20]=         0;
	coeff[ 21]=      1080;
	coeff[ 22]=        -0;
	coeff[ 23]=     -1344;
	coeff[ 24]=         0;
	coeff[ 25]=      1610;
	coeff[ 26]=        -0;
	coeff[ 27]=     -1863;
	coeff[ 28]=         0;
	coeff[ 29]=      2084;
	coeff[ 30]=        -0;
	coeff[ 31]=     -2257;
	coeff[ 32]=         0;
	coeff[ 33]=      2366;
	coeff[ 34]=        -0;
	coeff[ 35]=     30364;
	coeff[ 36]=        -0;
	coeff[ 37]=      2366;
	coeff[ 38]=         0;
	coeff[ 39]=     -2257;
	coeff[ 40]=        -0;
	coeff[ 41]=      2084;
	coeff[ 42]=         0;
	coeff[ 43]=     -1863;
	coeff[ 44]=        -0;
	coeff[ 45]=      1610;
	coeff[ 46]=         0;
	coeff[ 47]=     -1344;
	coeff[ 48]=        -0;
	coeff[ 49]=      1080;
	coeff[ 50]=         0;
	coeff[ 51]=      -835;
	coeff[ 52]=        -0;
	coeff[ 53]=       618;
	coeff[ 54]=         0;
	coeff[ 55]=      -437;
	coeff[ 56]=        -0;
	coeff[ 57]=       293;
	coeff[ 58]=         0;
	coeff[ 59]=      -185;
	coeff[ 60]=        -0;
	coeff[ 61]=       108;
	coeff[ 62]=         0;
	coeff[ 63]=       -58;
	coeff[ 64]=        -0;
	coeff[ 65]=        28;
	coeff[ 66]=         0;
	coeff[ 67]=       -11;
	coeff[ 68]=        -0;
	coeff[ 69]=         3;
	coeff[ 70]=        -0;



end

generate
genvar i;

for (i=0;i<71;i=i+1)begin: multi
	multiplier multi (.dataa(shiftReg[i]),.datab(coeff[i]),.result(multiRes[i]));

end
endgenerate


always @(posedge clk or posedge reset1) begin 
	if(reset1) begin //reset, set all shiftReg to 0
		result = 0; 
		for (j=0; j<N; j=j+1) begin 
			shiftReg[j] = 0; 
		end 
	end else begin  //shift
		for (j=N-1; j>0; j=j-1) begin 
			shiftReg[j] = shiftReg[j-1]; 
		end 
		shiftReg[0] = sample; 
		result = add[69];
	end 
	
	add[0] = multiRes[0]+multiRes[1];

	for (j=1;j<70;j=j+1)begin
		add[j] = add[j-1]+multiRes[j+1];
	
	end

 end 
 
endmodule
