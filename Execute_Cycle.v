`include"ALU.v"
`include"Mux.v"
`include"PC_Adder.v"
`include"Mux_2.v"


module Execute_Cycle( clk,rst, RegWrite_E ,ResultSrc_E ,MemWrite_E  , branch_E, ALUSrc_E ,ALUControl_E , RD_D_E, RD1_D_E , RD2_D_E ,Imm_Ext_E , PC_D_E , PC_Plus_4D_E, PC_Target_E, PC_Src_E,Forward_AE,Forward_BE ,RegWrite_M, ResultSrc_M , MemWrite_M,ALUResult_M , Write_Data_M, RD_D_E_M , PC_Plus_4D_E_M, Result_W);
input clk;
input rst;
input  RegWrite_E;  
input [1:0]  ResultSrc_E ;
input   MemWrite_E;
input   branch_E ;
input   ALUSrc_E ;
input [2:0]  ALUControl_E ;
input [4:0]  RD_D_E ; 
input [31:0]  RD1_D_E ;
input [31:0]  RD2_D_E ;
input [31:0]  Imm_Ext_E ;
input [31:0]  PC_D_E ;
input [31:0]  PC_Plus_4D_E ;
//

//hazard handling
input[31:0] Result_W;
input[1:0]Forward_AE,Forward_BE;


output RegWrite_M;
output [1:0]ResultSrc_M ;
output MemWrite_M ;
output [31:0]ALUResult_M ;
output [31:0]Write_Data_M;
output [4:0]RD_D_E_M;
output [31:0]PC_Plus_4D_E_M;
output [31:0] PC_Target_E;
output PC_Src_E;


wire [31:0]Src_B_E;
wire [31:0] ALU_Result_E;
wire Zero_E;

//hazard unit
wire [31:0]SRC_A;
wire [31:0]SRC_B_Mux;
//

reg RegWrite_E_R;
reg [1:0] ResultSrc_E_R;
reg MemWrite_E_R;
reg [31:0] ALU_Result_E_R;
reg [31:0] Write_Data_E_R;
reg [4:0] RD_D_E_R;
reg [31:0] PC_Plus_4D_E_R;


ALU ALU(.A( SRC_A),
        .B(Src_B_E),
        .ALUControl(ALUControl_E),
        .Result( ALU_Result_E),
        .zero(Zero_E),
        .Negative(),
        .carry(),
        .Overflow()
        );

Mux SRC_Mux_B2(.a(SRC_B_Mux),
        .b(Imm_Ext_E),
        .c(Src_B_E),
        .s(ALUSrc_E));

PC_Adder Adder(.a(PC_D_E),
               .b(Imm_Ext_E),
               .c(PC_Target_E)
               );

Mux_2 SRC_A_Mux(.a(RD1_D_E),
                .b( ALUResult_M),
                .c( Result_W),
                .sel(Forward_AE),
                .out(SRC_A));
               
Mux_2 SRC_Mux_B1(.a(RD2_D_E),
                .b( ALUResult_M),
                .c( Result_W),
                .sel(Forward_BE),
                .out(SRC_B_Mux));   

always@(posedge clk or negedge rst)
begin
    if(rst==1'b0)
    begin     
    RegWrite_E_R <=1'b0;
    ResultSrc_E_R <= 2'b00;
    MemWrite_E_R <= 1'b0;
    ALU_Result_E_R <=32'h00000000;
    Write_Data_E_R <= 32'h00000000;
    RD_D_E_R <= 5'b00000;
    PC_Plus_4D_E_R <= 32'h00000000;
    end
    
    else
    begin
    RegWrite_E_R <= RegWrite_E ;
    ResultSrc_E_R <= ResultSrc_E ;
    MemWrite_E_R <= MemWrite_E ;
    ALU_Result_E_R <= ALU_Result_E ;
    Write_Data_E_R <= SRC_B_Mux  ;
    RD_D_E_R <=  RD_D_E ;
    PC_Plus_4D_E_R <= PC_Plus_4D_E ;
    end
end
    assign PC_Src_E = (rst ==1'b1)? 1'b0: Zero_E && branch_E;
    assign RegWrite_M  = RegWrite_E_R ;
    assign ResultSrc_M = ResultSrc_E_R;
    assign MemWrite_M  =  MemWrite_E_R ;
    assign ALUResult_M =  ALU_Result_E_R;
    assign Write_Data_M = Write_Data_E_R;
    assign RD_D_E_M =  RD_D_E_R ;
    assign PC_Plus_4D_E_M =  PC_Plus_4D_E_R;

endmodule