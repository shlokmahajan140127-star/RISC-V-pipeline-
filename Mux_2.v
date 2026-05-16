`ifndef MUX_2_V
`define MUX_2_V


module Mux_2 (a,b,c,sel,out);
input[31:0]a;
input[31:0]b;
input[31:0]c;
input[1:0]sel;
output [31:0]out;

assign out = ((sel== 2'b00)?a:
             (sel== 2'b01)?b:
             (sel== 2'b10)?c: 32'h00000000
             );

endmodule
`endif