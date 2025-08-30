`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.08.2025 21:50:19
// Design Name: 
// Module Name: tb
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


module tb;
    
    reg clk_a, clk_b, rst_n, wr_en_i, rd_en_i;
    reg [3:0] wr_data_i;
    wire fifo_full_o, fifo_empty_o;
    wire [3:0] rd_data_o;
    
    top_module mod1( clk_a, clk_b, rst_n, wr_en_i, wr_data_i, rd_en_i, fifo_full_o, fifo_empty_o, rd_data_o );
    
    initial 
        begin
            clk_a = 1'b0;
            clk_b = 1'b0;
            rst_n = 1'b0;
            #12 rst_n = 1'b1;
            @(negedge clk_a);
            apply_write(16);
            @(negedge clk_b);
            apply_read(16);
            @(negedge clk_b);
            apply_read_write(3);
            repeat(5)
                @(negedge clk_b);
            $finish;
        end
        
    always #2 clk_a = !clk_a;
    always #5 clk_b = !clk_b;
    
    task apply_write;
        input [4:0] in1;
        begin
        wr_en_i = 1'b1;
        repeat(in1) begin
            wr_data_i = $random;
            @(negedge clk_a);
        end
        wr_en_i = 1'b0;
        end
    endtask
    
    task apply_read;
        input [4:0] in1;
        begin
        rd_en_i = 1'b1;
        repeat(in1) begin
            @(negedge clk_b);
        end
        rd_en_i = 1'b0;
        end
    endtask
    
    task apply_read_write;
        input [4:0] in1;
        fork
            begin
                @(negedge clk_a);
                wr_en_i = 1'b1;
                repeat(in1) begin
                    wr_data_i = $random;
                    @(negedge clk_a);
                end
                wr_en_i = 1'b0;
            end
            begin
                @(negedge clk_b);
                rd_en_i = 1'b1;
                repeat(in1) begin
                    @(negedge clk_b);
                end
                rd_en_i = 1'b0;
            end
        join
    endtask
    
endmodule
