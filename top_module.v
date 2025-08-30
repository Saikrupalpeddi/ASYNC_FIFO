`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.08.2025 22:52:04
// Design Name: 
// Module Name: top_module
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

module top_module(
    input wire clk_a,
    input wire clk_b,
    input wire rst_n,
    input wire wr_en_i,
    input wire [3:0] wr_data_i,
    input wire rd_en_i,
    output wire fifo_full_o,
    output wire fifo_empty_o,
    output wire [3:0] rd_data_o
    );
    
    wire [4:0] rd_ptr_rd_to_wr, wr_ptr_to_rd_ctrl, wr_ptr_wr_to_rd, rd_ptr_to_wr_ctrl, wr_ptr_wr_ctrl_to_2ff, rd_ptr_rd_ctrl_to_2ff, wr_ptr_2ff_rd_ctrl, rd_ptr_2ff_wr_ctrl;
    wire [3:0] wr_ptr_to_mem, rd_ptr_to_mem;
    wire wr_en_o, rd_en_o;

    write_ctrl a1( clk_a, rst_n, wr_en_i, rd_ptr_rd_to_wr, wr_en_o, wr_ptr_to_mem, wr_ptr_to_rd_ctrl, fifo_full_o ); 
    read_ctrl a2( clk_b, rst_n, rd_en_i, wr_ptr_wr_to_rd, rd_en_o, rd_ptr_to_mem, rd_ptr_to_wr_ctrl, fifo_empty_o );
    fifo_memory a3( clk_a, clk_b, wr_en_o, rd_en_o, wr_ptr_to_mem, wr_data_i, rd_ptr_to_mem, rd_data_o );
    b_g a4( wr_ptr_to_rd_ctrl, wr_ptr_wr_ctrl_to_2ff );
    b_g a5( rd_ptr_to_wr_ctrl, rd_ptr_rd_ctrl_to_2ff );
    g_b a6( wr_ptr_2ff_rd_ctrl, wr_ptr_wr_to_rd );
    g_b a7( rd_ptr_2ff_wr_ctrl, rd_ptr_rd_to_wr );
    
    genvar i;
    generate 
        for( i = 0; i < 5; i = i + 1 )
            two_ff_sync a8( clk_b, rst_n, wr_ptr_wr_ctrl_to_2ff[i], wr_ptr_2ff_rd_ctrl[i] );
    endgenerate
    
    genvar j;
    generate 
        for( j = 0; j < 5; j = j + 1 )
            two_ff_sync a9( clk_a, rst_n, rd_ptr_rd_ctrl_to_2ff[j], rd_ptr_2ff_wr_ctrl[j] );
    endgenerate
    
endmodule
