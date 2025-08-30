`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.08.2025 22:18:53
// Design Name: 
// Module Name: write_ctrl
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


module write_ctrl(
    input wire clk_i,
    input wire rst_n,
    input wire wr_en_i,
    input wire [4:0] rd_ptr_i,
    output wire wr_en_o,
    output wire [3:0] wr_ptr_to_mem,
    output wire [4:0] wr_ptr_to_rd_ctrl,
    output wire fifo_full_o
    );
    
    reg [4:0] wr_ptr;
    
    assign fifo_full_o = ( rd_ptr_i[3:0] == wr_ptr[3:0] ) && ( rd_ptr_i[4] != wr_ptr[4] );
    assign wr_ptr_to_mem = wr_ptr[3:0];
    assign wr_ptr_to_rd_ctrl = wr_ptr;
    assign wr_en_o = ( !fifo_full_o && wr_en_i );
    
    always @(posedge clk_i or negedge rst_n )
        begin
            if( !rst_n )
                wr_ptr <= 5'b0;
            else
                if( wr_en_o )
                    wr_ptr <= wr_ptr + 1'b1;
        end
    
endmodule
