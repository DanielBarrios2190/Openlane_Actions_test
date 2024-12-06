module MainDecoder(
    input [6:0] op,
    output reg Branch, Jump, MemWrite, ALUSrc, RegWrite,
    output reg [1:0] ResultSrc,
    output reg [2:0] ImmSrc,
    output reg [1:0] ALUOp
);

always @(*) begin
    case (op)
        7'b0000011: begin  // lw 
            RegWrite = 1'b1;
            ImmSrc = 3'b000;  
            ALUSrc = 1'b1;   
            MemWrite = 1'b0;   
            ResultSrc = 2'b01;
            Branch = 1'b0;
            ALUOp = 2'b00;
            Jump = 1'b0;
        end
        7'b0100011: begin  // sw 
            RegWrite = 1'b0;
            ImmSrc = 3'b001;  
            ALUSrc = 1'b1;   
            MemWrite = 1'b1;   
            ResultSrc = 2'bx;
            Branch = 1'b0;
            ALUOp = 2'b00;
            Jump = 1'b0;
        end
        7'b0110011: begin  // R-Type
            RegWrite = 1'b1;
            ImmSrc = 3'bx;  
            ALUSrc = 1'b0;   
            MemWrite = 1'b0;   
            ResultSrc = 2'b00;
            Branch = 1'b0;
            ALUOp = 2'b10;
            Jump = 1'b0;
        end
        7'b1100011: begin  // beq
            RegWrite = 1'b0;
            ImmSrc = 3'b010;  
            ALUSrc = 1'b0;   
            MemWrite = 1'b0;   
            ResultSrc = 2'bx;
            Branch = 1'b1;
            ALUOp = 2'b01;
            Jump = 1'b0;
        end
        7'b0010011: begin  // I-type ALU
            RegWrite = 1'b1;
            ImmSrc = 3'b000;  
            ALUSrc = 1'b1;   
            MemWrite = 1'b0;   
            ResultSrc = 2'b00;
            Branch = 1'b0;
            ALUOp = 2'b10;
            Jump = 1'b0;
        end
        7'b1101111: begin  // jal
            RegWrite = 1'b1;
            ImmSrc = 3'b011;  
            ALUSrc = 1'bx;   
            MemWrite = 1'b0;   
            ResultSrc = 2'b10;
            Branch = 1'b0;
            ALUOp = 2'bx;
            Jump = 1'b1;
        end
        7'b0110111: begin  // lui
            RegWrite = 1'b1;
            ImmSrc = 3'b100;  
            ALUSrc = 1'bx;   
            MemWrite = 1'b0;   
            ResultSrc = 2'b11;
            Branch = 1'b0;
            ALUOp = 2'bx;
            Jump = 1'b0;
        end
        default: begin  // opcode
            RegWrite = 1'b0;
            ImmSrc = 3'b000;  
            ALUSrc = 1'b0;   
            MemWrite = 1'b0;   
            ResultSrc = 2'b00;
            Branch = 1'b0;
            ALUOp = 2'b0;
            Jump = 1'b0;
        end
    endcase
end

endmodule