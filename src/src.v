module src(
    input clk,
    input reset,
    input [4:0] sw,
    input IR,
    output [3:0] led
);
wire Zero;
//Program Counter and Related:
reg [4:0] PC;
wire [4:0] PCNext, PCPlus1, PCTarget;
//Instruction:
wire [31:0] Instr;
//ALU:
wire [31:0] SrcA, SrcB;
wire [31:0] ALUResult;                          //ALU Output / RAM Input (A)
//wire Zero;
//RAM:
wire [31:0] ReadData;
wire [31:0] ReadDataOut;                        //RAM Output:
wire [31:0] WriteData;                          //RF Output (RD2) / RAM Input
//Control Unit Outputs:
wire PCSrc, MemWrite, ALUSrc, RegWrite;
wire [1:0] ResultSrc;
wire [2:0] ALUControl;
wire [2:0] ImmSrc;
//Misc Signals:
wire [31:0] ImmExt;                             //Extend Output:
reg [31:0] Result;                              //Mux Output / RF Input (WD3)

//_________________________________________________________________________//
assign PCNext = PCSrc ? PCTarget : PCPlus1;     //Mux del siguiente PC

always @(posedge clk) begin    //Registro de PC
    if (reset) begin
        PC <= 0; 
    end else begin
        PC <= PCNext;
    end
end

assign PCPlus1 = PC + 1;                        //Siguiente PC
assign PCTarget = ImmExt + PC;                  //PC objetivo para instrucciones tipo Branch
assign SrcB = ALUSrc ? ImmExt : WriteData;      //Mux de SrcB 

always @(*) begin                               //Mux 4 a 1 de Result
    case (ResultSrc)
        2'b00: Result = ALUResult;
        2'b01: Result = ReadDataOut; //Se cambio *******
        2'b10: Result = PCPlus1;
        2'b11: Result = ImmExt;
    endcase
end
//_________________________________________________________________________//
ROM ROM_Inst(
    //.clk(clk),
    .PC(PC),
    .Instr(Instr)
);

RegisterFile RegisterFile_Inst(
    .clk(clk),
    .A1(Instr[19:15]),
    .A2(Instr[24:20]),
    .A3(Instr[11:7]),
    .WD3(Result),
    .WE3(RegWrite),
    .RD1(SrcA),
    .RD2(WriteData)
);

Extend Extend_Inst(
    .Instr(Instr[31:7]),
    .ImmSrc(ImmSrc),
    .ImmExt(ImmExt)
);

ControlUnit ControlUnit_Inst(
    .op(Instr[6:0]),
    .funct3(Instr[14:12]),
    .funct7(Instr[30]),
    .Zero(Zero),
    .PCSrc(PCSrc),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite),
    .ResultSrc(ResultSrc),
    .ImmSrc(ImmSrc),
    .ALUControl(ALUControl)
);

ALU ALU_Inst(
    .SrcA(SrcA),
    .SrcB(SrcB),
    .ALUControl(ALUControl),
    .Zero(Zero),
    .ALUResult(ALUResult)
);

RAM RAM_Inst(
    .clk(clk),
    .we(MemWrite),
    .A(ALUResult[4:0]),
    .WD(WriteData),
    .RD(ReadData)
);

LEDBlock LEDBlock_per(
    .clk(clk),
    .D(WriteData[3:0]),
    .dir(ALUResult[4:0]),
    .MemWrite(MemWrite),
    .LED(led)
);

InputBlock InputBlock_per(
    .ReadData(ReadData),
    .sw(sw),
    .IR(IR),
    .dir(ALUResult[4:0]),
    .ReadDataOut(ReadDataOut)
);

endmodule
