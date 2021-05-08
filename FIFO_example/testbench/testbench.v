`timescale 1ns / 1ps
module testbench;
reg sys_clk 	= 1'b0;
reg start_test	= 1'b0;	
reg n_rst		= 1'b0;	
wire [3:0] leds;	

/* clk */
always #1 sys_clk <= ~sys_clk;

/* reset and start */
integer count_start = 0;
always@(posedge sys_clk) begin
	if(count_start <= 10) begin
		n_rst 		<= 1'b0;	
		start_test 	<= 1'b0;		
		count_start <= count_start + 1;
	end
	else begin 	
		n_rst 		<= 1'b1;	
		start_test	<= 1'b1;
	end
end


TOP uut( 
	.sys_clk_25M(sys_clk),
	.start_test(start_test),	
	.btn_n_rst(n_rst),	
	.leds(leds)	
);



endmodule
