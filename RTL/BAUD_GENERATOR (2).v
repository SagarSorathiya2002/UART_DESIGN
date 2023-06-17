module BAUD_GENERATOR(clk_in,rst,tx_clk,rx_clk,baud_sel,rx_tick);

input clk_in,rst;

input [1:0] baud_sel;

output reg tx_clk=0,rx_clk=0,rx_tick=0;

reg [14:0] tx_count=12'd0;

reg [10:0] rx_count=8'd0;

reg [4:0] baud_tick_count = 5'd0;


parameter TX_BAUD_2400  = 15'd20832,
          TX_BAUD_9600  = 15'd5200,
			 TX_BAUD_19200 = 15'd2608,
			 TX_BAUD_38400 = 15'd1296;
			 
			 
parameter RX_BAUD_2400  = 11'd1302,
          RX_BAUD_9600  = 11'd325,
			 RX_BAUD_19200 = 11'd163,
			 RX_BAUD_38400 = 11'd81;
			 

reg [14:0] TX_MAX_COUNT=TX_BAUD_9600;

reg [10:0] RX_MAX_COUNT=RX_BAUD_9600;

			 
always@(*)
begin

case(baud_sel)

2'd0:begin
     
	  TX_MAX_COUNT=TX_BAUD_2400;
	  RX_MAX_COUNT=RX_BAUD_2400; 
     
	  end
     
2'd1:begin

	  TX_MAX_COUNT=TX_BAUD_9600;
	  RX_MAX_COUNT=RX_BAUD_9600; 

     end
	  
2'd2:begin

	  TX_MAX_COUNT=TX_BAUD_19200;
	  RX_MAX_COUNT=RX_BAUD_19200; 

     end
	  
2'd3:begin

	  TX_MAX_COUNT=TX_BAUD_38400;
	  RX_MAX_COUNT=RX_BAUD_38400; 

     end
	  
default :begin
         TX_MAX_COUNT=TX_BAUD_2400;
	      RX_MAX_COUNT=RX_BAUD_2400; 
			end

endcase

end			 
			 
always@(posedge clk_in or posedge rst)
begin
if(rst)
begin
tx_clk=1'd0;
tx_count=15'd0;
end

else
begin

tx_count = tx_count+ 15'd1;

tx_clk=1'd0;

if(tx_count==TX_MAX_COUNT)
begin

tx_clk=1'd1;
tx_count=15'd0;

end


end


end


always@(posedge clk_in or posedge rst)
begin
if(rst)
begin
rx_clk=1'd0;
rx_count=11'd0;
end

else
begin

rx_count = rx_count+ 8'd1;

rx_clk=1'd0;

if(rx_count==RX_MAX_COUNT)
begin

rx_clk=1'd1;
rx_count=11'd0;

end


end


end


always@(posedge clk_in or posedge rst or posedge rx_clk)
begin

if(rst)
begin

baud_tick_count=4'd0;

rx_tick=1'd0;


end

else
begin

rx_tick=1'd0;

if(rx_clk)
begin

baud_tick_count=baud_tick_count+5'd1;


if(baud_tick_count==5'd7)

begin

rx_tick=1'd1;

end


end

if(baud_tick_count==5'd16)
begin

baud_tick_count=5'd0;

end



end


end

endmodule 