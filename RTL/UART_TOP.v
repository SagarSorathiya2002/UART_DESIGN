 module UART_TOP(input clk,rst,tx_enable,

output rx_bussy,rx_error,rx_valid,

output [7:0] RX_DATA,

input [1:0] baud_sel,

input [7:0] TX_BYTE,

output TX_VALID,TX_BUSSY,

output tx_clk,rx_clk,rx_tick,data,enable);

BAUD_GENERATOR bg(clk,rst,tx_clk,rx_clk,baud_sel,rx_tick);

UART_RX rx(clk,rst,enable,rx_clk,data,rx_tick,rx_bussy,rx_valid,rx_error,RX_DATA);

TRANSMITTER tx(clk,rst,tx_clk,data,TX_BYTE,TX_BUSSY,TX_VALID,tx_enable,enable,ind);


endmodule 