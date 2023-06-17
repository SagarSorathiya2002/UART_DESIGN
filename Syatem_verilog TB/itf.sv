interface itf(input bit clk);

       logic [7:0] tx_byte;
       logic [7:0] rx_byte;
       logic [1:0] baud_sel;
       logic tx_enable;
       logic rx_bussy,rx_error,rx_valid;
       logic TX_VALID,TX_BUSSY;
       logic rst; 
       logic tx_clk,rx_clk,rx_tick;


clocking cb_if@(posedge clk);

 output tx_byte;
 output baud_sel;
 output tx_enable;
 input  rx_byte;
 input  rx_bussy,rx_error,rx_valid,TX_VALID,TX_BUSSY;
 
endclocking 

modport DRIVE(clocking cb_if,input clk,rst);

endinterface 




