module ALU(A,B,ALUControl,Result,zero,Negative,carry,Overflow);
    input [31:0]A;
    input [31:0]B;
    input [2:0]ALUControl;
    output [31:0] Result;
    output zero;
    output Negative;
    output carry;
    output Overflow;

 wire[31:0] A_and_B;

 wire[31:0] A_OR_B;

 wire[31:0] NOT_B;

 wire[31:0] mux_1;

 wire[31:0] sum;

 wire[31:0] mux_2;
 
 wire [31:0] slt;

 wire cout;

// AND OPERATION
 assign A_and_B= A & B;

 //OR operation
 assign A_OR_B =A | B;

 //NOT operation
 assign NOT_B= ~B;

 //TERMINARY OPERATION
 assign mux_1 =(ALUControl[0] ==1'b0)?B :NOT_B;

//ADDITION / SUBSTRACTION operation
 assign {cout,sum}= A+ mux_1 +ALUControl[0];

// zero extension 
 assign slt ={31'b0,sum[31]};


// designing 4by1 mux
 assign mux_2=(ALUControl == 3'b000)? sum:
              (ALUControl == 3'b001)? sum:
              (ALUControl == 3'b010)? A_and_B :
              (ALUControl == 3'b011)? A_OR_B:
              (ALUControl == 3'b101)? slt : 32'h00000000;
                
 assign Result =mux_2;

//zero flag
assign zero= &(~Result);

// negative flag
assign Negative =Result[31];

// carry flag
assign carry =(~ALUControl[1 ]) & cout;

// overflow flag
assign Overflow =(ALUControl[1] & (A[31] ^sum[31]) ) &  (A[31] ^ B[31] ^ ALUControl[0]);

endmodule