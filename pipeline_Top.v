
`include "Fetch_Cycle.v"
`include "Decode_Cycle.v"
`include "Execute_Cycle.v"
`include "Memory_cycle.v"
`include "Write_back_Cycle.v"
`include "Hazard_Unit.v"

module Pipeline_Top(clk,rst);
input clk,rst;

wire PC_SRC_E ,ALUSrc_E,branch_E ;

wire  RegWrite_D ,  RegWrite_E , RegWrite_M ,RegWrite_W;
wire  MemWrite_D , MemWrite_E , MemWrite_M ;
wire[1:0]ResultSrc_D,ResultSrc_E ,ResultSrc_W;
wire [31:0] PC_Plus_4D_F,  PC_Plus_4D_D , PC_Plus_4D_E , PC_Plus_4D_M , PC_Plus_4D_W;
wire [31:0]Instr_D ,PC_F, PC_D, PC_E ,PC_M ,PC_W;

wire [31:0]PC_Target_E, Result_W;
wire [31:0]RD_D_E,RD1_D_E ,RD2_D_E ,Imm_Ext_E ;
wire [31:0]ALUResult_E ,ALUResult_M;
wire [31:0]Write_Data_M , Read_Data_W;
wire [4:0]  RD_E, RD_M, RD_W;
wire[2:0]ALUControl_D ;



//hazard_Unit
wire[4:0] RS1_E,RS2_E;
wire[1:0]Forward_AE,Forward_BE;
//

    Fetch_Cycle Fetch_Cycle(//input ports
                            .clk(clk),
                            .rst(rst),
                            .PC_Src_E(PC_SRC_E),

                            //output ports
                            .PC_Target_E(PC_Target_E),
                            .Instr_D(Instr_D),
                            .PCD(PC_F), 
                            .PC_Plus_4D(PC_Plus_4D_F)
                            );
    
    Decode_Cycle Decode_Cycle(  //input ports
                                .clk(clk),
                                .rst(rst),
                                .RegWrite_W(RegWrite_M),
                                .Result_W(Result_W),
                                .Instr_D( Instr_D),
                                .PCD(PC_F),
                                .PC_Plus_4D(PC_Plus_4D_F),
                                .RDW(RD_W),
                                //output ports
                                .RegWrite_E(RegWrite_D),
                                .ResultSrc_E(ResultSrc_D),
                                .MemWrite_E(MemWrite_D),
                                .branch_E(branch_E),
                                .ALUSrc_E(ALUSrc_E),
                                .ALUControl_E(ALUControl_D),
                                .RD_D_E( RD_E),
                                .RD1_D_E(RD1_D_E),
                                .RD2_D_E(RD2_D_E),
                                .Imm_Ext_E(Imm_Ext_E),
                                .PC_D_E(PC_D),
                                .PC_Plus_4D_E(PC_Plus_4D_D),
                                .RS1_D_E(RS1_E),
                                .RS2_D_E(RS2_E)
                                );

    Execute_Cycle Execute_Cycle(//input ports
                                .clk(clk),
                                .rst(rst),
                                .RegWrite_E(RegWrite_D),
                                .ResultSrc_E(ResultSrc_D),
                                .MemWrite_E(MemWrite_D),
                                .branch_E(branch_E),
                                .ALUSrc_E(ALUSrc_E),
                                .ALUControl_E(ALUControl_D),
                                .RD_D_E(RD_E),
                                .RD1_D_E(RD1_D_E),
                                .RD2_D_E(RD2_D_E),
                                .Imm_Ext_E(Imm_Ext_E),
                                .PC_D_E(PC_D), 
                                .PC_Plus_4D_E(PC_Plus_4D_D), 
                                .PC_Target_E(PC_Target_E), 
                                .PC_Src_E(PC_SRC_E), 
                                .Result_W(Result_W),
                                .Forward_AE(Forward_AE),
                                .Forward_BE(Forward_BE),

                                //output ports
                                .RegWrite_M(RegWrite_E), 
                                .ResultSrc_M(ResultSrc_E), 
                                .MemWrite_M(MemWrite_E),
                                .ALUResult_M(ALUResult_E),
                                .Write_Data_M(Write_Data_M), 
                                .RD_D_E_M(RD_M), 
                                .PC_Plus_4D_E_M(PC_Plus_4D_E)
                                );
    
    Memory_Cycle Memory_Cycle(  //input ports
                                .clk(clk),
                                .rst(rst),
                                .RegWrite_M(RegWrite_E),
                                .ResultSrc_M(ResultSrc_E),
                                .MemWrite_M(MemWrite_E), 
                                .Write_Data_M(Write_Data_M),
                                .RD_D_E_M(RD_M), 
                                .ALUResult_M(ALUResult_E),
                                .PC_Plus_4D_E_M(PC_Plus_4D_E),
                                //output ports
                                .RegWrite_W(RegWrite_M), 
                                .ResultSrc_W(ResultSrc_W), 
                                .ALU_Result_W(ALUResult_M), 
                                .Read_Data_W(Read_Data_W), 
                                .RD_D_E_M_W(RD_W),
                                .PC_Plus_4D_E_M_W(PC_Plus_4D_W)
                 );
    
    Write_back_Cycle Write_back_Cycle(//input ports
                                      .ResultSrc_W(ResultSrc_W), 
                                      .Read_Data_W(Read_Data_W), 
                                      .PC_Plus_4D_E_M_W(PC_Plus_4D_W),
                                      .ALU_Result_W(ALUResult_M), 
                                      //output ports
                                      .Result_W(Result_W) 
                                     );


    Hazard_Unit Hazard_Unit(.rst(rst),
                            .RS1_E( RS1_E),
                            .RS2_E(RS2_E),
                            .RD_M(RD_M),
                            .RD_W(RD_W),
                            .RegWrite_M(RegWrite_E),
                            .RegWrite_W(RegWrite_M),
                            .Forward_AE(Forward_AE),
                            .Forward_BE(Forward_BE)
                            );
endmodule
