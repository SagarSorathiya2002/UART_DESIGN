import transaction::*;
//`include"transaction.sv"

class UART_generator;
  
  // mailbox and event declaration
  mailbox gen2driv;
  event ended;
  
  // transaction delacaration 
  
  rand transaction trans;
  
  int no_of_counts;
  
  function new(mailbox gen2driv,event ended);
    
    this.gen2driv=gen2driv;
    this.ended = ended;
    
  endfunction
  
  

  
  task run;
    
  repeat(no_of_counts/4)
  begin
  trans=new();    
  if(!trans.randomize() with {trans.tx_byte<8'h44;})
begin
  $display("failed");
  $fatal("Gen:: trans randomization failed");  
   
end
    gen2driv.put(trans);
  end

  
  repeat(no_of_counts/4)
  begin
  trans=new();    
  if(!trans.randomize() with {trans.tx_byte<8'h88;
                              trans.tx_byte>8'h44;})
begin
  $display("failed");
  $fatal("Gen:: trans randomization failed");  
   
end
    gen2driv.put(trans);
  end
  
  

  repeat(no_of_counts/4)
  begin
  trans=new();    
  if(!trans.randomize() with {trans.tx_byte<8'hcc;
                              trans.tx_byte>8'h88;})
begin
  $display("failed");
  $fatal("Gen:: trans randomization failed");  
   
end
    gen2driv.put(trans);
  end
  
repeat(no_of_counts/4)
  begin
  trans=new();    
  if(!trans.randomize() with {trans.tx_byte<8'hff;
                              trans.tx_byte>8'hcc;})
begin
  $display("failed");
  $fatal("Gen:: trans randomization failed");  
   
end
    gen2driv.put(trans);
  end
  

 ->ended;
  
    
  endtask
   
  
   
  
  
endclass


