module LEDBlock (
    input clk,              //Reloj del Sistema
    input [3:0] D,          //Valor a escribir en los LEDs
    input [4:0] dir,        //Dirección
    input MemWrite,         //Enable de Escritura
    output reg [3:0] LED    //LEDs
);

reg enLED;
reg [3:0] nextLED;

always @ (*)
begin
    //Se revisa si hay que escribir y la dirección es la correcta
    if (dir == 5'd31 && MemWrite == 1) begin  
        enLED = 1;          //Activación del enable del LED 
        nextLED = D;        //Siguiente valor de los LEDs
    end
    else begin
        enLED = 0;
        nextLED = 0; 
    end
end 

always @ (posedge clk)      //Registro asociado a los LEDs
if (enLED) LED <= nextLED;
    
endmodule