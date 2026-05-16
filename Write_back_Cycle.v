`include "Mux_2.v"

module Write_back_Cycle(ResultSrc_W, Read_Data_W, PC_Plus_4D_E_M_W ,ALU_Result_W, Result_W );
input [1:0]ResultSrc_W;
input [31:0]Read_Data_W;
input [31:0]PC_Plus_4D_E_M_W ;
input [31:0]ALU_Result_W;

output [31:0]Result_W;

Mux_2 Mux_2(.a(ALU_Result_W),
        .b(Read_Data_W),
        .c(PC_Plus_4D_E_M_W),
        .sel(ResultSrc_W),
        .out(Result_W)
        );

endmodule
