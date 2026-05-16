`include"ControL_Unit_top.v"
`include"Registerfile.v"
`include"Sign_Extend.v"

module Decode_Cycle(clk,rst, RegWrite_W, Result_W, Instr_D, PCD ,PC_Plus_4D, RDW, RS1_D_E, RS2_D_E, RegWrite_E ,ResultSrc_E ,MemWrite_E  , branch_E, ALUSrc_E ,ALUControl_E , RD_D_E, RD1_D_E , RD2_D_E ,Imm_Ext_E , PC_D_E , PC_Plus_4D_E);
input clk, rst, RegWrite_W;
input [4:0] RDW;
input [31:0] Instr_D, PCD, PC_Plus_4D ,Result_W;

output  RegWrite_E;  
output[1:0]  ResultSrc_E ;
output  MemWrite_E;
output  branch_E ;
output  ALUSrc_E ;
output[2:0]  ALUControl_E ;
output[4:0]  RD_D_E ; 
output[31:0]  RD1_D_E ;
output[31:0]  RD2_D_E ;
output[31:0]  Imm_Ext_E ;
output[31:0]  PC_D_E ;
output[31:0]  PC_Plus_4D_E ;
output[4:0]RS1_D_E;
output[4:0]RS2_D_E;



wire[4:0] RD;
wire Regwrite_D;
wire ALUSrc_D;
wire [1:0]ImmSrc_D;
wire MemWrite_D;
wire [1:0]ResultSrc_D;
wire [2:0]ALUControl_D;
wire branch_D;
wire [31:0] RD1_D;
wire [31:0] RD2_D; 
wire [31:0] Imm_Ext_D;

wire[4:0]RS1_E,RS2_E;

reg RegWrite_D_R;
reg [1:0]ResultSrc_D_R;
reg MemWrite_D_R;
reg branch_D_R;
reg ALUSrc_D_R;
reg [2:0]ALUControl_D_R;
reg [4:0] RD_D_R;
reg [31:0] RD1_D_R;
reg [31:0] RD2_D_R;
reg [31:0] Imm_Ext_D_R;
reg [31:0] PC_D_R;
reg [31:0] PC_Plus_4D_R;

reg[4:0]RS1_D_R;
reg[4:0]RS2_D_R;

assign RD= Instr_D[11:7];
assign RS1_E =Instr_D[19:15];
assign RS2_E =Instr_D[24:20];
//Control_Unit

Control_unit Control_Unit(
                          .ALUControl(ALUControl_D),
                          .func_7(Instr_D[31:25]),
                          .func_3(Instr_D[14:12]),
                          .ResultSrc( ResultSrc_D),
                          .MemWrite(MemWrite_D),
                          .ALUSrc(ALUSrc_D),
                          .ImmSrc(ImmSrc_D),
                          .branch(branch_D),
                          .RegWrite(Regwrite_D),
                          .op_code(Instr_D[6:0])
                          );

//Register_File
register_file register_file(
                            .A1(Instr_D[19:15]),
                            .A2(Instr_D[24:20]),
                            .A3(RDW),
                            .WD3(Result_W),
                            .WE3(RegWrite_W),
                            .rst(rst),
                            .clk(clk),
                            .RD1(RD1_D),
                            .RD2(RD2_D)
                            );

//Sign_Extend
Sign_Extend Sign_Extend(
                        .In(Instr_D),
                        .Imm_Ext(Imm_Ext_D),
                        .ImmSrc(ImmSrc_D)
                        );

//declaring the Register logic
always@(posedge clk or negedge rst)
begin
    if(rst ==1'b0)
    begin
    RegWrite_D_R <= 1'b0;
    ResultSrc_D_R <= 2'b00;
    MemWrite_D_R <= 1'b0;
    branch_D_R <= 1'b0;
    ALUSrc_D_R <= 1'b0;
    ALUControl_D_R <= 3'b000;
    RD_D_R <= 5'b00000;
    RD1_D_R <= 32'h00000000;
    RD2_D_R <= 32'h00000000;
    Imm_Ext_D_R <= 32'h00000000;
    PC_D_R <= 32'h00000000;
    PC_Plus_4D_R <= 32'h00000000;
    RS1_D_R <= 5'b00000;
    RS2_D_R <= 5'b00000;
    end

    else
    begin
    RegWrite_D_R <= Regwrite_D;
    ResultSrc_D_R <= ResultSrc_D ;
    MemWrite_D_R <= MemWrite_D ;
    branch_D_R <= branch_D ;
    ALUSrc_D_R <= ALUSrc_D ;
    ALUControl_D_R <= ALUControl_D;
    RD_D_R <= RD;
    RD1_D_R <= RD1_D;
    RD2_D_R <= RD2_D;
    Imm_Ext_D_R <= Imm_Ext_D;
    PC_D_R <= PCD;
    PC_Plus_4D_R <= PC_Plus_4D;
    RS1_D_R <= RS1_E;
    RS2_D_R <= RS2_E;
    end
end
    // output assign statement
    assign  RegWrite_E  = RegWrite_D_R;
    assign  ResultSrc_E = ResultSrc_D_R;
    assign  MemWrite_E = MemWrite_D_R;
    assign  branch_E =  branch_D_R;
    assign  ALUSrc_E =  ALUSrc_D_R;
    assign  ALUControl_E = ALUControl_D_R;  
    assign  RD_D_E  =  RD_D_R;
    assign  RD1_D_E =  RD1_D_R; 
    assign  RD2_D_E =  RD2_D_R;
    assign  Imm_Ext_E = Imm_Ext_D_R;
    assign  PC_D_E   =  PC_D_R ;
    assign  PC_Plus_4D_E =  PC_Plus_4D_R;
    assign RS1_D_E = RS1_D_R;
    assign RS2_D_E = RS2_D_R ;
    
endmodule