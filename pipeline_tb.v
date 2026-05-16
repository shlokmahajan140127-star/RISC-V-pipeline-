module tb();
reg clk =1'b0 ,rst;
Pipeline_Top pipeline_Top(
    .clk(clk),
    .rst(rst)
);

always begin
     #50 clk = ~clk;
    
end

initial begin
    rst <= 1'b0;
    #200;
    rst <= 1'b1;
    #2000;
    $finish;
end

initial begin
    $dumpfile("dump_2.vcd");
    $dumpvars(0, tb);
end

endmodule