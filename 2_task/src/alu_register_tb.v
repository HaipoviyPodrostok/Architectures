`timescale 1ns/1ps

module alu_register_tb();

  localparam WIDTH = 8;
  localparam CLK_TIME = 10;

  reg clk_i;
  reg arstn_i;
  reg valid_i;
  reg  [WIDTH-1:0] first_i;
  reg  [WIDTH-1:0] second_i;
  reg  [1:0]       opcode_i;

  wire             valid_o;
  wire [WIDTH-1:0] result_o;

  alu_register #(
    .WIDTH(WIDTH)
  ) test (
    .clk_i    (clk_i),
    .arstn_i  (arstn_i),
    .valid_i  (valid_i),
    .first_i  (first_i),
    .second_i (second_i),
    .opcode_i (opcode_i),
    .valid_o  (valid_o),
    .result_o (result_o)
  );

  always #(CLK_TIME / 2) clk_i = ~clk_i;

  initial begin
    $dumpfile("alu_test.vcd");
    $dumpvars(0, alu_register_tb);
    
    clk_i    = 1'b0;
    arstn_i  = 1'b0;
    valid_i  = 1'b0;
    first_i  = 8'd0;
    second_i = 8'd0;
    opcode_i = 2'b00;

    #18 arstn_i = 1'b1;

    @(negedge clk_i);
      valid_i  <= 1'b1;
      opcode_i <= 2'b00;
      first_i  <= 8'd2;
      second_i <= 8'd2;

    @(negedge clk_i);
      valid_i  = 1'b0;

    #30  $finish;
  end

endmodule