module Extend(
    input [31:7] Instr,
    input [2:0] ImmSrc,
    output reg [31:0] ImmExt
);

always @(*) begin
    case (ImmSrc)
        3'b000: ImmExt = {{20{Instr[31]}}, Instr[31:20]};                                   // Caso ImmSrc == 000
        3'b001: ImmExt = {{20{Instr[31]}}, Instr[31:25], Instr[11:7]};                      // Caso ImmSrc == 001
        3'b010: ImmExt = {{22{Instr[31]}}, Instr[7], Instr[30:25], Instr[11:9]};
        //3'b010: ImmExt = {{21{Instr[31]}}, Instr[7], Instr[30:25], Instr[11:8]};      // Caso ImmSrc == 010 
        3'b011: ImmExt = {{14{Instr[31]}}, Instr[19:12], Instr[20], Instr[30:22]};
        //3'b011: ImmExt = {{13{Instr[31]}}, Instr[19:12], Instr[20], Instr[30:21]};    // Caso ImmSrc == 011
        3'b100: ImmExt = {Instr[31:12], 12'b000000000000};                                  // Caso ImmSrc == 100
        default: ImmExt = 32'd0;                                                            // Valor por defecto
    endcase
end

endmodule