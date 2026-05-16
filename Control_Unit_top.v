// `include "ALU_decoder.v"
`include "main_decoder.v"
`include "ALU_decoder.v"
module Control_unit(ALUControl,PCSrc,op5,zero,func_7,func_3,ResultSrc,MemWrite,ALUSrc,ImmSrc,RegWrite,op_code,branch);

input [6:0] op_code,func_7;
input [2:0]func_3;
input op5;// not this is the normal op of [6:0] you need 6th bit that's why its written like that
input zero;
output [1:0]ResultSrc;
output MemWrite;
output ALUSrc;
output RegWrite;
output branch;
output [1:0]ImmSrc;
output [2:0] ALUControl;
output PCSrc;


wire [1:0] ALU_opcode;
wire branch_O;

assign branch = branch_O;
 ALU_decoder ALU_decoder(
    .ALUControl(ALUControl),
    .op5(op5),
    .func_7(func_7[5]),
    .func_3(func_3),
    .ALU_opcode(ALU_opcode)
    );

 main_decoder main_decoder(
    .ResultSrc(ResultSrc),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .ImmSrc(ImmSrc),
    .RegWrite(RegWrite),
    .op_code(op_code),
    .ALU_opcode(ALU_opcode),
    .zero(zero),
    .branch(branch_O),
    .PCSrc(PCSrc)
 );
 
endmodule