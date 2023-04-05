module echo_machine (input sample_clock1, input signed [15:0] input_sample1, output reg signed[15:0]  output_sample1);
	wire signed[15:0] delay, feedback;
	assign feedback = output_sample1;
	
	shiftregister shiftReg1(.clock(sample_clock1), .shiftin(feedback), .shiftout(delay),.taps());
	
	always @(posedge sample_clock1)
	begin
		output_sample1 <= (delay>>8) + input_sample1;
	end
	
endmodule 