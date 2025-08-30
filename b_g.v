`timescale 1ns / 1ps


module b_g(
    input wire [4:0] in_i,
    output wire [4:0] out_o);
    
    assign out_o[4] = in_i[4];
    assign out_o[3] = in_i[4] ^ in_i[3];
    assign out_o[2] = in_i[3] ^ in_i[2];
    assign out_o[1] = in_i[2] ^ in_i[1];
    assign out_o[0] = in_i[1] ^ in_i[0];
    
endmodule
