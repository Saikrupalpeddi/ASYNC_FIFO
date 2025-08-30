`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.08.2025 21:40:04
// Design Name: 
// Module Name: two_ff_sync
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


module two_ff_sync(
    input wire clk_i,
    input wire rst_n,
    input wire in_i,
    output wire out_o);
    
    reg [1:0] sync_ff;
    
    assign out_o = sync_ff[0];
    
    always @( posedge clk_i  or negedge rst_n )
        begin
            if( !rst_n )
                sync_ff <= 2'b0;
            else
                begin
                    sync_ff[1] <= in_i;
                    sync_ff[0] <= sync_ff[1];
                end
        end
endmodule
