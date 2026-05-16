`include "Data_memory.v"

module Memory_Cycle(clk,rst,RegWrite_M,ResultSrc_M,MemWrite_M, Write_Data_M ,RD_D_E_M, ALUResult_M,PC_Plus_4D_E_M ,RegWrite_W, ResultSrc_W , ALU_Result_W, Read_Data_W, RD_D_E_M_W ,PC_Plus_4D_E_M_W );
input clk , rst;
input RegWrite_M;
input [1:0]ResultSrc_M;
input [31:0]ALUResult_M;
input [31:0]Write_Data_M;
input MemWrite_M;
input [4:0]RD_D_E_M;
input [31:0]PC_Plus_4D_E_M;

wire [31:0]RD_M;
wire[31:0] ALU_Result_M_M;

reg [1:0]ResultSrc_M_R;
reg RegWrite_M_R;
reg [31:0]ALUResult_M_R;
reg [31:0]PC_Plus_4D_E_M_R;
reg [4:0]RD_D_E_M_R;
reg [31:0]Read_Data_M_R;

output [31:0]Read_Data_W;
output RegWrite_W;
output [1:0]ResultSrc_W;
output [31:0]ALU_Result_W;
output [31:0]PC_Plus_4D_E_M_W;
output [4:0]RD_D_E_M_W;


assign   ALU_Result_M_M = ALUResult_M ;
Data_Memory Data_Memory(.clk(clk),
                        .rst(rst),
                        .A(ALUResult_M),
                        .WD(Write_Data_M),
                        .WE(MemWrite_M),
                        .RD(RD_M)
                        );

always@(posedge clk or negedge rst)
  begin
    if(rst ==1'b0)
        begin 
        ResultSrc_M_R <= 2'b00;
        RegWrite_M_R <= 1'b0;
        ALUResult_M_R <= 32'h00000000;
        PC_Plus_4D_E_M_R <= 32'h00000000;
        RD_D_E_M_R <= 5'b00000;
        Read_Data_M_R <= 32'h00000000;
        end
    else
        begin
        ResultSrc_M_R <= ResultSrc_M ;
        RegWrite_M_R <= RegWrite_M;
        ALUResult_M_R <= ALU_Result_M_M;
        PC_Plus_4D_E_M_R <=  PC_Plus_4D_E_M ;
        RD_D_E_M_R <= RD_D_E_M;
        Read_Data_M_R <= RD_M;
        end
  end

  
 assign RegWrite_W  =  RegWrite_M_R;
 assign ResultSrc_W  = ResultSrc_M_R;
 assign ALU_Result_W = ALUResult_M_R;
 assign PC_Plus_4D_E_M_W = PC_Plus_4D_E_M_R;
 assign RD_D_E_M_W = RD_D_E_M_R;
 assign Read_Data_W  =  Read_Data_M_R;

 endmodule
