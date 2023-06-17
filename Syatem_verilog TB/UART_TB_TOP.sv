module UART_TB_TOP;

reg clk =0;

itf vif(clk);

UART_TEST test(vif);

int no_of_success,file_discriminator;

UART_TOP DUT(.clk(vif.clk),
             .rst(vif.rst),
             .tx_enable(vif.tx_enable),
             .RX_DATA(vif.rx_byte),
             .baud_sel(2'd3),
             .TX_BYTE(vif.tx_byte),
             .TX_VALID(vif.TX_VALID),
             .TX_BUSSY(vif.TX_BUSSY),
             .tx_clk(vif.tx_clk),
             .rx_clk(vif.rx_clk),
             .rx_tick(vif.rx_tick),
             .rx_bussy(vif.rx_bussy),
             .rx_valid(vif.rx_valid),
             .rx_error(vif.rx_error));



always #1 clk=~clk;




endmodule 

