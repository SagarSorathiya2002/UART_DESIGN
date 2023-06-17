import transaction::*;

class UART_scoreboard;

transaction trans;
virtual itf vif;
mailbox mon2sb;
event ended;

int no_of_sucess=0;

real coverage_percentage=0;

covergroup cg ;

RX_BYTE : coverpoint trans.rx_byte {bins rx[] ={[0:255]};}
TX_BYTE : coverpoint trans.tx_byte {bins tx[] ={[0:255]};}
RX_VALID : coverpoint trans.rx_valid ;
TX_VALID : coverpoint trans.TX_VALID ;

endgroup 


function new(virtual itf vif,mailbox mon2sb,event ended);

this.vif=vif;
this.mon2sb=mon2sb;
this.ended=ended;
cg=new;
cg.start();

endfunction 

task comparator();

forever
begin
mon2sb.get(trans);

cg.sample();

if(trans.tx_byte==trans.rx_byte)
begin

no_of_sucess=no_of_sucess+1;

end

end

endtask


function real get_coverage_report();

coverage_percentage=cg.get_coverage();

return coverage_percentage;

endfunction 

endclass  
