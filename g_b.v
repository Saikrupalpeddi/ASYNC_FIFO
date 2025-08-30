`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.08.2025 22:16:58
// Design Name: 
// Module Name: g_b
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module g_b(
    input wire [4:0] in_i,
    output wire [4:0] out_o);
    
    assign out_o[4] = in_i[4];
    assign out_o[3] = out_o[4] ^ in_i[3];
    assign out_o[2] = out_o[3] ^ in_i[2];
    assign out_o[1] = out_o[2] ^ in_i[1];
    assign out_o[0] = out_o[1] ^ in_i[0];
    
endmodule
