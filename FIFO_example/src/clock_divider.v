//leo-Ne
module clock_divider(
input wire clk,          
output reg divided_clk=0,  // 1Hz => 0.5s on and 0.5s off\
output reg divided_clk_deg180=1
);
        
parameter div_value   = 4;
integer counter_value = 1;

always@ (posedge clk) begin
    // keep counting until div_value
    if(counter_value == div_value)
        counter_value <= 1;                     // reset value
    else
        counter_value <= counter_value + 1;     // count up
end

always@ (posedge clk) begin
    if(counter_value == div_value) begin
        divided_clk <= ~divided_clk;    
		divided_clk_deg180 <= ~divided_clk_deg180;        
	end
    else begin
        divided_clk <= divided_clk;    
		divided_clk_deg180 <= divided_clk_deg180;        
	end
end
endmodule
