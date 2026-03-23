module alu_register #(
  parameter WIDTH = 8
) (
  input wire clk_i,    
  input wire arstn_i,  
  input wire valid_i,  
  
  input wire [WIDTH-1:0] first_i,  
  input wire [WIDTH-1:0] second_i, 
  input wire [1:0]       opcode_i,
  
  output wire             valid_o,
  output wire [WIDTH-1:0] result_o
);

  reg [WIDTH-1:0] alu_result;
  reg [WIDTH-1:0] result_reg;
  reg             valid_reg;

  always @(*) begin
    alu_result = {WIDTH{1'b0}};
    
    case(opcode_i)
      2'b00: alu_result = first_i + second_i;
      2'b01: alu_result = ~(first_i & second_i);
      2'b10: alu_result = $signed(second_i) <<< first_i;
      2'b11: alu_result = (second_i != first_i);
    endcase 
  end

  always @(posedge clk_i or negedge arstn_i) begin
    if (!arstn_i) begin
        valid_reg <= 1'b0;
    end else begin
        valid_reg <= valid_i;
        if (valid_i) begin
            result_reg <= alu_result;
        end
    end
  end


  assign result_o = result_reg;
  assign valid_o  = valid_reg;

endmodule


