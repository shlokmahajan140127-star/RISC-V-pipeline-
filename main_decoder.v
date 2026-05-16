module main_decoder(PCSrc,ResultSrc,MemWrite,ALUSrc,ImmSrc,RegWrite,op_code,zero,ALU_opcode,branch);
input [6:0] op_code;
input zero;
output [1:0]ResultSrc;
output MemWrite;
output ALUSrc;
output [1:0]ImmSrc;
output RegWrite;
output branch;
output [1:0]ALU_opcode;
output PCSrc;

wire branch_O;

// assign RegWrite =((op_code == 7'b0000011) |  (op_code == 7'b0110011) )   ? 1'b1 : 1'b0;


assign RegWrite =((op_code == 7'b0000011) | 
     (op_code == 7'b0110011) |   
     (op_code == 7'b0010011))
     ? 1'b1 : 1'b0;

assign MemWrite =(op_code ==7'b0100011)?1'b1 :1'b0;

assign ResultSrc =(op_code ==7'b0000011)? 2'b01 : 2'b00;

assign branch  =(op_code == 7'b1100011) ?1'b1 :1'b0;

assign ALUSrc =((op_code ==7'b0100011) | (op_code == 7'b0000011) |(op_code == 7'b0010011))?1'b1 :1'b0;

assign ImmSrc =(op_code == 7'b0100011 ) ?2'b01 : (op_code == 7'b1100011) ?2'b10 :2'b00;

assign ALU_opcode =(op_code == 7'b0110011) ?2'b10 :(op_code == 7'b1100011)?2'b01 :2'b00;


assign PCSrc = branch_O & zero;
assign branch_O = branch;

endmodule