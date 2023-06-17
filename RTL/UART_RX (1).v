module UART_RX(clk,rst,rx_en,rx_clk,rx_in,rx_tick,rx_bussy,rx_valid,rx_error,RX_DATA);

input clk,rst,rx_en,rx_clk,rx_in,rx_tick;

output rx_bussy,rx_error,rx_valid;

output reg [7:0] RX_DATA=8'd0;

parameter IDEAL = 3'd0,
          START = 3'd1,
			 DATA  = 3'd2,
			 STOP  = 3'd3,
			 ERROR = 3'd4;
	
reg [2:0] current_state=IDEAL;

reg [3:0] count = 4'd0;

reg [7:0] REG_RX_BYTE=8'd0;

// flag Assignment

assign rx_bussy = (current_state==DATA)?1:0;

assign rx_error = (current_state==ERROR)?1:0;

assign rx_valid = (current_state==STOP)?((rx_tick)?(rx_in?1:0):0):0;
	
	
always@(posedge clk or posedge rst)
begin
if(rst)
begin

current_state=IDEAL;

end

else
begin

case(current_state)

IDEAL :
       begin
		 
		 if(rx_en)
		 
		 current_state = START;
		 
		 end
	
START :
       begin
		 
		 if(rx_tick)
		 begin
		 
		 if(!rx_in)
		 begin
		 current_state=DATA;
		 count=4'd8; 
		 end
		 else
		 
		 current_state = ERROR;
		 
		 end
		 
		 end

DATA :
      begin
		
		if(rx_tick)
		begin
		count=count-4'd1;
		REG_RX_BYTE[count]=rx_in;
		end
		
		if(count==4'd0)
		begin
		
		current_state=STOP;
		
		end
		
		end

STOP :
      begin
		
		if(rx_tick)
		 begin
		 
		 if(rx_in)
		 begin
		 current_state = IDEAL;
		 
		 RX_DATA=REG_RX_BYTE;		 
		 end
		 else
      
		 current_state = ERROR;
		 
		end
		
		end

ERROR :
       begin
				// current_state=IDEAL;
		 
		 end


endcase


end

end


endmodule 