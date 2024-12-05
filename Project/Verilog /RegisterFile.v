module RegisterFile (
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input clk,
    input [31:0] WD3,
    input WE3,
    output reg [31:0] RD1,
    output reg [31:0] RD2
);
    
reg [31:0] en;
reg [31:0] Q1, Q2, Q3, Q4, Q5; 
reg [31:0] Q6, Q7, Q8, Q9, Q10; 
reg [31:0] Q11, Q12, Q13, Q14, Q15;
reg [31:0] Q16, Q17, Q18, Q19, Q20;
reg [31:0] Q21, Q22, Q23, Q24, Q25;
reg [31:0] Q26, Q27, Q28, Q29, Q30;
reg [31:0] Q31, Q0;

always @(posedge clk)
begin
    if (en[0])
        Q0 <= WD3;
    Q0 <= 0;            //Registro x0 que siempre vale Cero
end

always @(posedge clk)
begin
    if (en[1])
        Q1 <= WD3;
end

always @(posedge clk)
begin
    if (en[2])
        Q2 <= WD3;
end

always @(posedge clk)
begin
    if (en[3])
        Q3 <= WD3;
end

always @(posedge clk)
begin
    if (en[4])
        Q4 <= WD3;
end

always @(posedge clk)
begin
    if (en[5])
        Q5 <= WD3;
end

always @(posedge clk)
begin
    if (en[6])
        Q6 <= WD3;
end

always @(posedge clk)
begin
    if (en[7])
        Q7 <= WD3;
end

always @(posedge clk)
begin
    if (en[8])
        Q8 <= WD3;
end

always @(posedge clk)
begin
    if (en[9])
        Q9 <= WD3;
end

always @(posedge clk)
begin
    if (en[10])
        Q10 <= WD3;
end

always @(posedge clk)
begin
    if (en[11])
        Q11 <= WD3;
end

always @(posedge clk)
begin
    if (en[12])
        Q12 <= WD3;
end

always @(posedge clk)
begin
    if (en[13])
        Q13 <= WD3;
end

always @(posedge clk)
begin
    if (en[14])
        Q14 <= WD3;
end

always @(posedge clk)
begin
    if (en[15])
        Q15 <= WD3;
end

always @(posedge clk)
begin
    if (en[16])
        Q16 <= WD3;
end

always @(posedge clk)
begin
    if (en[17])
        Q17 <= WD3;
end

always @(posedge clk)
begin
    if (en[18])
        Q18 <= WD3;
end

always @(posedge clk)
begin
    if (en[19])
        Q19 <= WD3;
end

always @(posedge clk)
begin
    if (en[20])
        Q20 <= WD3;
end

always @(posedge clk)
begin
    if (en[21])
        Q21 <= WD3;
end

always @(posedge clk)
begin
    if (en[22])
        Q22 <= WD3;
end

always @(posedge clk)
begin
    if (en[23])
        Q23 <= WD3;
end

always @(posedge clk)
begin
    if (en[24])
        Q24 <= WD3;
end

always @(posedge clk)
begin
    if (en[25])
        Q25 <= WD3;
end

always @(posedge clk)
begin
    if (en[26])
        Q26 <= WD3;
end

always @(posedge clk)
begin
    if (en[27])
        Q27 <= WD3;
end

always @(posedge clk)
begin
    if (en[28])
        Q28 <= WD3;
end

always @(posedge clk)
begin
    if (en[29])
        Q29 <= WD3;
end

always @(posedge clk)
begin
    if (en[30])
        Q30 <= WD3;
end

always @(posedge clk)
begin
    if (en[31])
        Q31 <= WD3;
end


always @(*)
begin
    case (A1)
        5'd0: RD1 = Q0;
        5'd1: RD1 = Q1;
        5'd2: RD1 = Q2;
        5'd3: RD1 = Q3;
        5'd4: RD1 = Q4;
        5'd5: RD1 = Q5;
        5'd6: RD1 = Q6;
        5'd7: RD1 = Q7;
        5'd8: RD1 = Q8;
        5'd9: RD1 = Q9;
        5'd10: RD1 = Q10;
        5'd11: RD1 = Q11;
        5'd12: RD1 = Q12;
        5'd13: RD1 = Q13;
        5'd14: RD1 = Q14;
        5'd15: RD1 = Q15;
        5'd16: RD1 = Q16;
        5'd17: RD1 = Q17;
        5'd18: RD1 = Q18;
        5'd19: RD1 = Q19;
        5'd20: RD1 = Q20;
        5'd21: RD1 = Q21;
        5'd22: RD1 = Q22;
        5'd23: RD1 = Q23;
        5'd24: RD1 = Q24;
        5'd25: RD1 = Q25;
        5'd26: RD1 = Q26;
        5'd27: RD1 = Q27;
        5'd28: RD1 = Q28;
        5'd29: RD1 = Q29;
        5'd30: RD1 = Q30;
        5'd31: RD1 = Q31;
        default: RD1 = 32'd0;
    endcase
end

always @(*)
begin
    case (A2)
        5'd00: RD2 = Q0;
        5'd01: RD2 = Q1;
        5'd02: RD2 = Q2;
        5'd03: RD2 = Q3;
        5'd04: RD2 = Q4;
        5'd05: RD2 = Q5;
        5'd06: RD2 = Q6;
        5'd07: RD2 = Q7;
        5'd08: RD2 = Q8;
        5'd09: RD2 = Q9;
        5'd10: RD2 = Q10;
        5'd11: RD2 = Q11;
        5'd12: RD2 = Q12;
        5'd13: RD2 = Q13;
        5'd14: RD2 = Q14;
        5'd15: RD2 = Q15;
        5'd16: RD2 = Q16;
        5'd17: RD2 = Q17;
        5'd18: RD2 = Q18;
        5'd19: RD2 = Q19;
        5'd20: RD2 = Q20;
        5'd21: RD2 = Q21;
        5'd22: RD2 = Q22;
        5'd23: RD2 = Q23;
        5'd24: RD2 = Q24;
        5'd25: RD2 = Q25;
        5'd26: RD2 = Q26;
        5'd27: RD2 = Q27;
        5'd28: RD2 = Q28;
        5'd29: RD2 = Q29;
        5'd30: RD2 = Q30;
        5'd31: RD2 = Q31;
        default: RD2 = 32'd0;
    endcase
end

always @(*)
begin

    case ({~WE3,A3})
        6'd00: en = 32'b00000000000000000000000000000001;
        6'd01: en = 32'b00000000000000000000000000000010;
        6'd02: en = 32'b00000000000000000000000000000100;
        6'd03: en = 32'b00000000000000000000000000001000;
        6'd04: en = 32'b00000000000000000000000000010000;
        6'd05: en = 32'b00000000000000000000000000100000;
        6'd06: en = 32'b00000000000000000000000001000000;
        6'd07: en = 32'b00000000000000000000000010000000;
        6'd08: en = 32'b00000000000000000000000100000000;
        6'd09: en = 32'b00000000000000000000001000000000;
        6'd10: en = 32'b00000000000000000000010000000000;
        6'd11: en = 32'b00000000000000000000100000000000;
        6'd12: en = 32'b00000000000000000001000000000000;
        6'd13: en = 32'b00000000000000000010000000000000;
        6'd14: en = 32'b00000000000000000100000000000000;
        6'd15: en = 32'b00000000000000001000000000000000;
        6'd16: en = 32'b00000000000000010000000000000000;
        6'd17: en = 32'b00000000000000100000000000000000;
        6'd18: en = 32'b00000000000001000000000000000000;
        6'd19: en = 32'b00000000000010000000000000000000;
        6'd20: en = 32'b00000000000100000000000000000000;
        6'd21: en = 32'b00000000001000000000000000000000;
        6'd22: en = 32'b00000000010000000000000000000000;
        6'd23: en = 32'b00000000100000000000000000000000;
        6'd24: en = 32'b00000001000000000000000000000000;
        6'd25: en = 32'b00000010000000000000000000000000;
        6'd26: en = 32'b00000100000000000000000000000000;
        6'd27: en = 32'b00001000000000000000000000000000;
        6'd28: en = 32'b00010000000000000000000000000000;
        6'd29: en = 32'b00100000000000000000000000000000;
        6'd30: en = 32'b01000000000000000000000000000000;
        6'd31: en = 32'b10000000000000000000000000000000;
        default: en = 32'd0;   //Antes tenía a "RD1" en lugar de "en"
    endcase
end

endmodule