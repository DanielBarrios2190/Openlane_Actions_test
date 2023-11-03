module ControlUnit(
    input [6:0] op,
    input [2:0] funct3,
    input [5:5] funct7,
    input Zero,
    output PCSrc, MemWrite, ALUSrc, RegWrite,
    output [1:0] ResultSrc,
    output [2:0] ALUControl,
    output [2:0] ImmSrc
    );

wire Branch, Jump;
wire [1:0] ALUOp;
assign PCSrc = (Branch & Zero) | Jump;

MainDecoder MainDecoder_Inst(
    .op(op),
    .Branch(Branch),
    .Jump(Jump),
    .ResultSrc(ResultSrc),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .ImmSrc(ImmSrc),
    .RegWrite(RegWrite),
    .ALUOp(ALUOp)
);

ALUDecoder ALUDecoder_Inst(
  .funct3(funct3), 
  .funct7_5(funct7[5]),
  .op_5(op[5]), 
  .ALUControl(ALUControl), 
  .ALUOp(ALUOp)
);

endmodule