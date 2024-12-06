module InputBlock (
    input [31:0] ReadData,          //Valor Leído
    input [4:0] sw,                 //Entrada de los switches y botones
    input IR,                       //Entrada del sensor infrarrojo
    input [4:0] dir,                //Dirección de memoria
    output reg [31:0] ReadDataOut   //Valor de lectura final
);

always @(*) begin
    if(dir == 5'd29)                     //Dirección del sensor infrarrojo
        ReadDataOut = {{31{1'b0}},IR};
    else if(dir == 5'd30)                //Dirección de los los interruptores
        ReadDataOut = {{27{1'b0}},sw};
    else
        ReadDataOut = ReadData;          //Si no, se continúa igual que siempre
end
    
endmodule