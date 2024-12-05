module ALU (
  input [31:0] SrcA,
  input [31:0] SrcB,
  input [2:0] ALUControl,
  output reg Zero,
  output reg [31:0] ALUResult
);

  always @(*) begin
    case (ALUControl)
      3'b000: ALUResult = SrcA + SrcB;                  //Suma
      3'b001: ALUResult = SrcA - SrcB;                  //Resta
      3'b010: ALUResult = SrcA & SrcB;                  //And
      3'b011: ALUResult = SrcA | SrcB;                  //Or
      3'b100: ALUResult = SrcA ^ SrcB;                  //Xor
      3'b101: ALUResult = (SrcA < SrcB) ? 1 : 0;        //SLT
      default: ALUResult = 32'd0;                       //Si no se tiene ningún código fijar la salida a 0
    endcase
    Zero = (ALUResult == 0) ? 1 : 0;                    //Verificar si la salida es 0
  end

endmodule