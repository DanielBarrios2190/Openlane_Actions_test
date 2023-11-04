module src(
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to 
    
    );
    
    wire [2:0] bits ;

    reg [7:0] cnt;
    wire [7:0] duty;
    reg pwm_q,ppm_q;
    reg [2:0] bits_pre;
    wire pwm_d,ppm_d;

    assign duty = ui_in [7:0];
    assign bits = uio_in[2:0];

    assign uio_oe = 8'b11111000;
    assign uio_out[7:0] = 8'b00000000;
    assign uo_out[7:1] = 7'b0000000;
    
    always @(posedge clk) begin
      if(rst_n) begin
        bits_pre <= bits;
        if(bits_pre != bits) begin
            cnt <= 8'd0;
            pwm_q <= 1'b0;
        end
        else begin
            
            pwm_q <= pwm_d;
                     
            if((cnt >= (2**bits)))
                cnt <= 0;
            else begin     
                cnt <= cnt + 1;
            end
        end
        bits_pre <= bits;
      end else begin
         pwm_q <= 1'b0;
         cnt <= 0;
         bits_pre <= bits;
      end
    end

    
    assign pwm_d = (cnt < duty);
    assign uo_out[0] = pwm_q;
    


endmodule

