`ifndef MUX_V
`define MUX_V

module Mux(a,b,c,s);
input [31:0]a,b;
input s;
output [31:0]c;

assign c= (~s)? a :b;
endmodule
`endif
// assign c= (s==1'b0)?a :b;
//assign c= (~s)? a :b;