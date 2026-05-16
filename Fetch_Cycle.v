`include"Mux.v"
`include"PC_Counter.v"
`include"instruction_memory.v"
`include"PC_Adder.v"


module Fetch_Cycle(clk, rst, PC_Src_E ,PC_Target_E, Instr_D, PCD , PC_Plus_4D);
input clk ,rst;
input PC_Src_E;
input [31:0] PC_Target_E;
output [31:0]Instr_D;
output [31:0] PCD;
output [31:0] PC_Plus_4D;

wire [31:0] PC_F ;
wire [31:0] PCF;
wire [31:0] PC_Plus_4F;
wire [31:0] Instr_F;

reg[31:0] InstrF_reg;
reg[31:0] PCF_reg;
reg[31:0] PC_Plus_4F_reg;

    Mux PC_mux (.a(PC_Plus_4F),
                .b(PC_Target_E),
                .c(PC_F ),
                .s(PC_Src_E));

    PC_counter PC_Counter(.clk(clk),
                .rst(rst),
                .PC_next( PC_F),
                .PC(PCF)
                );

    instruction_memory instruction_memory(.A(PCF),
                                        .RD(Instr_F),
                                        .rst(rst)
                                        );

    PC_Adder PC_Adder(.a(PCF),
                    .b(32'h00000004),
                    .c(PC_Plus_4F)
                    );

//Fetch cycle register logic
always@(posedge clk or negedge rst)
begin

    if(rst ==1'b0)
    begin
        InstrF_reg <=32'h00000000;
        PCF_reg <= 32'h00000000;
        PC_Plus_4F_reg <= 32'h00000000;
    end
    
    else
    begin
        InstrF_reg <= Instr_F;
        PCF_reg  <=  PCF;
        PC_Plus_4F_reg <= PC_Plus_4F;
    end
end


// assigning instruction values to the register part
assign Instr_D = InstrF_reg;
assign PCD = PCF_reg;
assign PC_Plus_4D = PC_Plus_4F_reg;


endmodule