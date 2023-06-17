`include"UART_driver.sv"
`include"UART_monitor.sv"
`include"UART_generator.sv"
`include"UART_scoreboard.sv"

class UART_environment;


UART_generator gen;
UART_driver driv;
UART_monitor mon;
UART_scoreboard sb;

transaction trans;
mailbox gen2driv=new();
mailbox mon2sb=new();

int result;
event ended;
virtual itf vif;

function new(virtual itf vif);

this.vif=vif;

gen=new(gen2driv,ended);
driv=new(vif,gen2driv);
mon=new(vif,mon2sb);
sb=new(vif,mon2sb,ended);

endfunction

task pre_test;

repeat(5) @(posedge vif.clk);
driv.reset;

endtask

task main;
fork
gen.run();
driv.tx_mode();
mon.fetch();
mon.error();
sb.comparator();

join_any

endtask


task post_test;

wait(ended.triggered);

wait(gen.no_of_counts==driv.no_count);

report();

endtask

task report;

$display("******************* REPORT *******************");
$display("Sent Packets : 1000");
$display("Error Packet : %d",mon.getErrorCount);
$display("Obtained Coverage = %f",sb.get_coverage_report);

endtask

task run;

pre_test;
main;
post_test;

endtask

endclass 