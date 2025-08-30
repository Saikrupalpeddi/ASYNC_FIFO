`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.08.2025 22:36:37
// Design Name: 
// Module Name: read_ctrl
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


module read_ctrl(
    input wire clk_i,
    input wire rst_n,
    input wire rd_en_i,
    input wire [4:0] wr_ptr_i,
    output wire rd_en_o,
    output wire [3:0] rd_ptr_to_mem,
    output wire [4:0] rd_ptr_to_wr_ctrl,
    output wire fifo_empty_o
    );
    
    reg [4:0] rd_ptr;
    
    assign fifo_empty_o = ( rd_ptr == wr_ptr_i );
    assign rd_ptr_to_mem = rd_ptr[3:0];
    assign rd_ptr_to_wr_ctrl = rd_ptr;
    assign rd_en_o = ( !fifo_empty_o && rd_en_i );
    
    always @(posedge clk_i or negedge rst_n )
        begin
            if( !rst_n )
                rd_ptr <= 5'b0;
            else
                if( rd_en_o )
                    rd_ptr <= rd_ptr + 1'b1;
        end
    
endmodule

