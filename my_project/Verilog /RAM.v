//My memory

module RAM
	# (parameter N=5, M=32)
	(
	input clk,
	input we,
	input [N-1:0] A,
	input [M-1:0] WD,
	output [M-1:0] RD
	);

reg [M-1:0] my_mem [2**N-1:0];

always @ (posedge clk)
if (we) my_mem[A] <= WD;

assign RD = my_mem[A];
endmodule
