`timescale 1ns / 1ps

module testbench;

reg sys_clk = 1'b0;
reg n_rst	= 1'b0;
reg en      = 1'b0;

reg signed [7:0] A;		//signed data;	
reg signed [7:0] B;		//signed data;	
wire signed [7:0] C;		//signed data;	
wire signed [7:0] D;		//signed data;	
wire signed [14:0] E;		//signed data;	
wire signed [7:0] F;		//signed data;	

// parameter
integer cnt_start = 0;

// reg
reg signed [7:0] cnt_data = 8'sd0; 

always #1 sys_clk = ~sys_clk;

always@(posedge sys_clk) begin
	if(cnt_start < 2 )begin
		cnt_start <= cnt_start + 1;	
		n_rst	  <= 1'b0;				
        en	   	  <= 1'b0;
	end        
	else if(cnt_start < 3 ) begin 	
		cnt_start <= cnt_start + 1;	
		n_rst	  <= 1'b1;				
        en	   	  <= 1'b0;
	end        
	else begin	
		en	   	  <= 1'b1;
	end
end

/* generate the input data */
assign input_data = cnt_data;
always@(posedge sys_clk) begin
	if(en) begin
		cnt_data <= cnt_data + 8'sd1;
		A        <= cnt_data;
		B[7]        <= ~cnt_data[7];
		B[6:0]        <= ~cnt_data[6:0] + 7'b1;
	end		
	else begin	
		cnt_data <= cnt_data;
		A        <= cnt_data;
		B[7]        <= ~cnt_data[7];
		B[6:0]        <= ~cnt_data[6:0] + 7'b1;
	end
end

Subtract u_subtract(
	.n_rst(n_rst),
	.clk(sys_clk),
	
	.A(A),
	.B(B),
	.C(C),
	.D(D),
	
	.E(E),
	.F(F)
);



endmodule
