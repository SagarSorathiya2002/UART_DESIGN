`include"UART_environment.sv"


program UART_TEST(itf.DRIVE vif);

UART_environment env;

int no_of_sucess,file_discriminator;

initial
begin

env=new(vif);
env.gen.no_of_counts=10000;
env.run;
end




endprogram
