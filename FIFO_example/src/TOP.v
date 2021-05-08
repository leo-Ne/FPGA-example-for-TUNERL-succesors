module TOP( 
	input wire sys_clk_25M,
	input wire start_test,	
	input wire btn_n_rst,	
	output reg [3:0] leds	
);

/* clk module */
wire clk1;			// I want a frequency clock.
wire clk1_deg180;	
/* fifo module */
wire wrst;
wire we;
wire [7:0] wr_data;
wire full_flag;

//wire [7:0] trans_data;
wire empty_flag;
wire [8:0] fifo_wrpointer;
wire [8:0] fifo_rdpointer;

wire re;
wire rrst;
wire [7:0] 	read_data;
wire [7:0] 	rd_data;
wire 		rd_valid;

wire [3:0] 	cnt_leds;
wire [3:0] 	debug_leds;
assign debug_leds[0] = full_flag ^ empty_flag;
assign debug_leds[1] = we;
assign debug_leds[2] = full_flag;
assign debug_leds[3] = rd_valid;

clock_divider #(.div_value(1)) 
u_xx_clk(
.clk(sys_clk_25M),          
.divided_clk(clk1),  // 1Hz => 0.5s on and 0.5s off
.divided_clk_deg180(clk1_deg180)
);


always@(posedge sys_clk_25M) begin
	leds <= ~cnt_leds;
//	leds[1:0] <= ~cnt_leds[1:0];
//	leds[2]   <= ~debug_leds[2];
//	leds[3] <= ~debug_leds[3];
end	

write_FIFO #(.start(0), .stop(255))
u_write_fifo (
	.n_rst(btn_n_rst),			// reset signal, '0' is valid.
	.clk(clk1),					// clk with 10MHz.	
 	.clk_deg180(clk1_deg180), 	// clk_deg180 = ~clk.	
 	 			
	.wrst(wrst),	
	.we(we),					// write enable.	
	.trans_data(wr_data),		// trans_data.	
	.full_flag(full_flag),		// 	
	.empty_flag(empty_flag)
);	

read_FIFO #(.cnt_to_light_led(202400))
u_read_fifo(
	.n_rst(btn_n_rst),
	.clk(clk1),	
	.clk_deg180(clk1_deg180),
		
	.re(re),		
	.rrst(rrst),	
	.trans_data(read_data),	
	.full_flag(full_flag),	
	.empty_flag(empty_flag),		

	.rd_data(rd_data),		// read module ouput;
	.rd_valid(rd_valid),
	.cnt_leds(cnt_leds)
);

U_FIFO u_xx_fifo(
	.wrst(wrst),
    .rrst(rrst),
    .di(wr_data),
    .clk(clk1_deg180),
    .we(we),
    .re(re),
    .dout(read_data),
    .empty_flag(empty_flag),
    .full_flag(full_flag),
    .fifo_wrpointer(fifo_wrpointer),
    .fifo_rdpointer(fifo_rdpointer)
);

endmodule
