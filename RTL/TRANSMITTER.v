module TRANSMITTER(clk,rst,tx_clk,tx_out,TX_BYTE,TX_BUSSY,TX_VALID,tx_enable,tx_en,ind);

input clk,rst,tx_clk,tx_enable;

input [7:0] TX_BYTE;

output reg tx_out,tx_en,TX_VALID;

output TX_BUSSY;

parameter IDEAL = 2'd0,
          STARTING = 2'd1,
			 DATA = 2'd2,
			 STOP = 2'd3;

reg [1:0] current_state =IDEAL;

reg [7:0] REG_TX_BYTE=8'd0;

reg [3:0] index=4'd0;

output reg [3:0] ind=4'd0;

//flags 

assign TX_BUSSY=current_state==DATA?1:0;

always@(*)
begin

REG_TX_BYTE=TX_BYTE;

end
			 
always@(posedge clk or posedge rst)
begin
if(rst)
begin

current_state=IDEAL;
tx_out=1'd1;

end

else
begin

tx_en=1'b0;

TX_VALID=1'd0;

case(current_state)

IDEAL :
       begin
		 
		 tx_out=1'd1;
		 
		 ind[0]=1'b1;
		 
		 if(tx_enable)
		 begin
		 
		 if(tx_clk)
		 begin
		 
		 tx_en=1'b1;
		 
		 current_state=STARTING;
		 
		 end
		 
		 end
		 
		 
		 
		 end

STARTING :
       begin

		 tx_out=1'b0;

       		 ind[1]=1'b1;		 
		 current_state=DATA;
		 
		 index =4'd8;
		 
		 
		 
		 end

DATA :
       begin
		 		 ind[2]=1'b1;
		 if(tx_clk)
		 begin
		 index=index-4'd1;
		 
		 tx_out=REG_TX_BYTE[index];
		 
		 if(index==4'd0)
		 begin
		 
		 current_state=STOP;
		 
		 end
		 
		 
		 end
		 
		 
		 end

STOP :    
      begin
		 
		 		 ind[3]=1'b1;
		 if(tx_clk)
		 begin
		 
		 tx_out=1'd1;
		 
		 current_state = IDEAL;
		 
		 TX_VALID=1'd1;
		 
		 end
		 
		 end

default : current_state = IDEAL;



endcase 


end




end


endmodule 