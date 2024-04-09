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

  // integer max_pc = 864;
  // integer cycles = (max_pc / 4) + 10;
  integer cycles = 20000;
  
  integer i;

  initial begin
    clk = 0;
    clk_step = 0;
    reset = 1;
    clk_select = 0;

    #1;
    reset = 0;

    for(i = 0; i < cycles; i = i+1) #20;
    
    $stop;
  end

  always #10 clk = ~clk;
endmodule