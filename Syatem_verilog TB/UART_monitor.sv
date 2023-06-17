/*`ifdef DRIVER_SV
`include"transaction.sv"
`endif */

import transaction::*;

class UART_monitor;

virtual itf vif;
mailbox mon2sb;
rand transaction trans;
int no_of_errors=0;

function new(virtual itf vif,mailbox mon2sb);
this.vif=vif;
this.mon2sb=mon2sb;
endfunction 

task fetch;

forever
begin
trans=new();
wait(vif.TX_VALID);
trans.tx_byte=vif.tx_byte;
trans.rx_error=vif.rx_error;
trans.TX_VALID=vif.TX_VALID;
wait(vif.rx_valid==1);
@(posedge vif.clk);
trans.rx_byte=vif.rx_byte;
trans.rx_valid=vif.rx_valid;

mon2sb.put(trans);

end

endtask

task error();
forever
begin
wait(vif.rx_error==1);
no_of_errors++;
end

endtask

function int getErrorCount();

return no_of_errors;

endfunction


task main();

fork

fetch();
error();

join_any

endtask


endclass 
