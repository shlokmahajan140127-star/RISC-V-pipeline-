module Hazard_Unit(rst,RS1_E,RS2_E,RD_M,RD_W,RegWrite_M ,RegWrite_W ,Forward_AE,Forward_BE);
input rst;
input [4:0]RS1_E ,RS2_E;
input [4:0] RD_M,RD_W;
input RegWrite_M, RegWrite_W;
output [1:0]Forward_AE;
output [1:0]Forward_BE;


assign Forward_AE = 
                    ((RegWrite_M==1'b1)&& (RD_M != 5'b00000) && (RD_M == RS1_E))?2'b10:
                    ((RegWrite_W==1'b1)&& (RD_W != 5'b00000) && (RD_W == RS1_E))?2'b01:2'b00;


assign Forward_BE =
                   ((RegWrite_M==1'b1)&& (RD_M != 5'b00000) && (RD_M == RS2_E))?2'b10:
                   ((RegWrite_W==1'b1)&& (RD_W != 5'b00000) && (RD_W == RS2_E))?2'b01:2'b00;

endmodule