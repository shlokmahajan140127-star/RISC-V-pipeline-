module register_file(A1,A2,A3,WD3,WE3,rst,clk,RD1,RD2);
input rst;
input clk;
input [4:0]A1;
input [4:0]A2;
input [4:0]A3;
input [31:0]WD3;
input WE3;
output[31:0]RD1;
output[31:0]RD2;

reg[31:0] Register[31:0];



always@(posedge clk or negedge rst)
  begin
    if(WE3)
    begin
    Register[A3] <= WD3;
    end
  end

  assign RD1=(~rst) ?32'd0 :Register[A1];
  assign RD2=(~rst) ?32'd0 :Register[A2];

  // initial begin
  //   Register[0] = 32'd0;
  // end
  integer i;   // ✅ declare here (outside)

initial begin
    for (i = 0; i < 32; i = i + 1)
        Register[i] = 32'd0;
end
endmodule
