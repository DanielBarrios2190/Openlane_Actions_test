module ALUDecoder(
    input [2:0] funct3,
    input funct7_5,
    input op_5,
    input [1:0] ALUOp,
    output reg [2:0] ALUControl
);

always @(*) begin
    case (ALUOp)
        2'b00: ALUControl = 3'b000;                             //Suma
        2'b01: ALUControl = 3'b001;                             //Resta
        2'b10: case (funct3)                                    
                    3'b000: case ({op_5, funct7_5})
                                2'b11: ALUControl = 3'b001;     //Resta
                                default: ALUControl = 3'b000;   //Suma
                            endcase 
                    3'b010: ALUControl = 3'b101;                //SLT
                    3'b100: ALUControl = 3'b100;                //XOR
                    3'b110: ALUControl = 3'b011;                //OR
                    3'b111: ALUControl = 3'b010;                //AND
                    default: ALUControl = 3'b000;               //Default
                endcase
        default: ALUControl = 3'b000;
    endcase
end

endmodule

