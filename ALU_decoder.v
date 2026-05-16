// note op5 is just 6th bit of op_code([5])
module ALU_decoder(ALUControl,op5,func_7,func_3,ALU_opcode);
input [2:0]func_3;
input func_7;
input op5;
input  [1:0] ALU_opcode;
output [2:0] ALUControl;

wire [1:0] concatenation;
assign concatenation ={op5,func_7};

assign ALUControl =(ALU_opcode == 2'b00)? 3'b000:
                   (ALU_opcode == 2'b01)? 3'b001:
                   ((ALU_opcode == 2'b10) && (func_3 == 3'b010))? 3'b101:
                   ((ALU_opcode == 2'b10) && (func_3 == 3'b110))? 3'b011:
                   ((ALU_opcode == 2'b10) && (func_3 == 3'b111))? 3'b010:
                   ((ALU_opcode == 2'b10) && (func_3 == 3'b000) &&(concatenation == 2'b11))? 3'b001:
                   ((ALU_opcode == 2'b10) && (func_3 == 3'b000) &&(concatenation != 2'b11))? 3'b000:3'b000;
                   
endmodule
