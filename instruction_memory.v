module instruction_memory(A,RD,rst);
input [31:0]A;
input rst;
output  [31:0]RD;

reg [31:0] mem[1023:0];
assign RD =(rst ==1'b0) ? {32{1'b0}} :mem[A[31:2]];


initial begin
   mem[0] = 32'h00500293; // addi x5, x0, 5
    mem[1] = 32'h00300313; // addi x6, x0, 3
    mem[2] = 32'h006283B3; // add x7, x5, x6
    mem[3] = 32'h00002403; // lw x8, 0(x0)
    mem[4] = 32'h00100493; // addi x9, x0, 1
    mem[5] = 32'h00940533; // add x10, x8, x9
end
endmodule
