//`include"UART_generator.sv"
import transaction::*;
class UART_driver;

virtual itf vif;

mailbox gen2driv;

transaction trans;

int no_count=0;

function new(virtual itf vif,mailbox gen2driv);

this.vif=vif;
this.gen2driv=gen2driv;

endfunction 

task reset;

vif.tx_byte=7'd0;
vif.tx_enable=1'd0;

repeat(5) @(posedge vif.clk);

vif.rst<=1'd0;

endtask 


task tx_mode;

forever
begin

gen2driv.get(trans);

@(posedge vif.clk)

vif.tx_byte<=trans.tx_byte;

@(posedge vif.clk)

vif.tx_enable<=1'd1;

wait(vif.TX_VALID==1'd1)

no_count++;

end


endtask 


endclass

