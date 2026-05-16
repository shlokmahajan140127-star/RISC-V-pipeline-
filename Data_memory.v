module Data_Memory(clk,rst,A,WD,WE,RD);
input clk;
input rst;
input [31:0] A;
input [31:0] WD;
input WE;
output [31:0] RD;

reg [31:0] mem[1023:0];

assign RD =(rst ==1'b0) ?32'd0 :mem[A];

always@(posedge clk)
begin
 if(WE)
    mem[A] <= WD;
end

initial
begin
mem[28] = 32'h00000020;
mem[40] = 32'h00000002;
end

endmodule