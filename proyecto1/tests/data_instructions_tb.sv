`timescale 10ns/10ns

module data_instructions_tb();
  logic clk;
  logic clk_step;
  logic reset;
  logic clk_select;

  procesadorArm dut(
    .clk(clk),
    .clk_step(clk_step),
    .rst(reset),
    .clk_select(clk_select)
  );

  initial begin
    clk = 0;
    clk_step = 0;
    reset = 1;
    clk_select = 0;

    #1;
    reset = 0;

    #10000;
    
    $stop;
  end

  always #10 clk = ~clk;
endmodule