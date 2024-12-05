//My memory

module ROM
	# (parameter BITS_DATA=32, 			//Data width
           parameter BITS_ADDR=5 		//Address width
        )(
	//input clk,						// Clock 
	input [BITS_ADDR-1:0] PC,			// Address bus
	output reg [BITS_DATA-1:0] Instr	//Output data
	);
	
// Memory array (depth x width): 2^5= 32_rows x 32_bits
reg [BITS_DATA-1:0] memoria [0: (2**BITS_ADDR)-1];

// 	data_width 	name	memory_depth
//	big-endian: the most significant byte  is at the lowest address

// Output update
//always @ (posedge clk)
always @ (*)
 Instr <= memoria[PC];

//The following code initializes the ROM contents via an external file
//with data in hexadecimal readmemh or use $readmemb for data in binary

initial
 $readmemb("MemoriaPrograma.mem",	//File name
	    memoria,					//Memory array name
	    0,							//Start Address
	    (2**BITS_ADDR)-1			//Stop Address
);
endmodule
