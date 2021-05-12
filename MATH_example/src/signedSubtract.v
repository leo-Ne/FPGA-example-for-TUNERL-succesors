module Subtract(
	input wire n_rst,
	input wire clk,
	
	input wire signed [7:0] A,
	input wire signed [7:0] B,
	
	output reg signed [8:0] C,
	output reg signed [7:0] D,
	output reg signed [14:0] E,
	output reg signed [7:0] F
);

always@(posedge clk or negedge n_rst) begin
	if(!n_rst) begin
		C <= 9'sd0;
		D <= 8'sd0;
		E <= 15'sd0;
		F <= 8'sd0;
	end
	else begin
		C <= A + B;
		D <= A - B;
		E <= A * B;
		F <= A / B;
	end
end

endmodule
	
