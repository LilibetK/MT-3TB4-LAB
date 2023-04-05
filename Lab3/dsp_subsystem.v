module dsp_subsystem (input sample_clock,  input reset, input [1:0] selector, input [15:0] input_sample, output reg[15:0] output_sample);

//assign output_sample = input_sample;
 wire[15:0]echoRes;
 wire[15:0]filterRes;//name change after finish filter

 echo_machine echo1(.sample_clock1(sample_clock), .input_sample1(input_sample), .output_sample1(echoRes));
 FIR_filter filter1(.clk(sample_clock), .reset1(reset), .sample(input_sample), .result(filterRes));
 
//3to1 multiplexer
 
 always @(posedge sample_clock)
 begin
  case(selector)
   2'b00: output_sample = input_sample;
   2'b01: output_sample = filterRes;//name change after finish filter
   2'b10: output_sample = echoRes;
   default:
    output_sample = input_sample;
  endcase
 end
 
 

endmodule