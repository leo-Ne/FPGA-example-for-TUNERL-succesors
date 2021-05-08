module read_FIFO(
	input wire n_rst,
	input wire clk,		
	input wire clk_deg180,
		
	output reg re,		
	output reg rrst,	
	input  wire signed [7:0] trans_data,	
	input  wire full_flag,	
	input  wire empty_flag,	

	output reg 	signed [7:0] rd_data,
	output reg 		 rd_valid,
	output reg [3:0] cnt_leds=4'd0
);

/* parameter to use in the practically */
parameter cnt_to_light_led = 102400;

parameter start = 0;
parameter stop = 255;

reg [3:0] leds = 4'd0;

/* log trans information */
reg [23:0] cnt_trans_data = 24'd0;

/* reg to check */
reg [7:0] count = 8'd0;
	

always@(posedge clk_deg180 or negedge n_rst) begin
	if(!n_rst) begin
		re   		<= 1'b0;	
		rd_valid 	<= 1'b0;		
		rrst 		<= 1'b1;			
	end	
	else begin	
		rrst 		<= 1'b0;
		if(empty_flag) begin		
			re				<= 1'b0;		
			rd_valid 		<= 1'b0;			
		end			
		else if(full_flag)begin		
			re				<= 1'b1;		
			rd_valid 		<= 1'b1;				
		end				
		else begin			
			re				<= re;		
			rd_valid 		<= rd_valid;		
		end
	end
end


// re 和 rd_valid 时序有问题。
always@(posedge clk or negedge n_rst) begin
	if(!n_rst) begin
		cnt_trans_data 	<=  24'd0;				
		rd_data			<= 8'd0;			
	end
	else begin 	
		if(re && cnt_trans_data != cnt_to_light_led) begin 				
			rd_data	<= trans_data; 		
			cnt_trans_data 	<=  cnt_trans_data + 24'd1;			
		end			
		else if(re && cnt_trans_data == cnt_to_light_led) begin		
			rd_data	<= trans_data; 		
			cnt_trans_data 	<=  24'd1;	
		end
	end		
end	

/* test leds */
always@(posedge clk or negedge n_rst) begin
	if(!n_rst) begin
		cnt_leds <= 4'd0;	
	end
	else begin 		
		if(rd_data == count && cnt_trans_data == cnt_to_light_led )
			cnt_leds <= cnt_leds + 4'd1;										
	end
end

/* checking */
always@(posedge clk or negedge n_rst) begin
	if(!n_rst) begin
		count <= start;
	end		
	else begin	
		if(re && count < stop) begin	
			count <= count + 8'd1;
		end			
		else if(re && count ==  stop) begin		
			count <= start;
		end
	end

end

endmodule
