// leo-Ne 

module write_FIFO(
	input wire n_rst,			// reset signal, '0' is valid.
	input wire clk,				// clk with 10MHz.	
 	input wire clk_deg180, 		// clk_deg180 = ~clk.	
		
	// FIFO interface			
	output reg			wrst,	
	output reg			we,				// write enable.	
	output reg	[7:0]	trans_data,		// trans_data.
//	input  wire			afull_flag,		// almost empty flag.		
	input  wire 		full_flag,		// 	
	input  wire 		empty_flag
);

//para
parameter start = 0;
parameter stop  = 255;
// reg
reg [7:0] 	count = 8'd0;

integer cnt_trans_data = 0;

// generate data.
always@(posedge clk) begin
	trans_data <= count[7:0];
end

always@(posedge clk or negedge n_rst) begin
	if(!n_rst) begin
		count <= start;		
		wrst  <= 1'b1;	
	end		
	else begin		
		wrst <= 1'b0;
		if(we && count < stop) begin
			count <= count + 8'd1;	
		end			
		else if(we && count == stop ) begin		
			count <= start;
		end
	end
end

always@(posedge clk_deg180 or negedge n_rst) begin
//	if(afull_flag | full_flag) begin
	if(!n_rst) begin
		we <= 1'b1;	
	end		
	else if(full_flag) begin
		we <= 1'b0;			
	end
	else if(empty_flag) begin
		we <= 1'b1;	
		cnt_trans_data = cnt_trans_data + 1;
	end		
	else begin	
		cnt_trans_data = cnt_trans_data + 1;
	end
end		

endmodule	