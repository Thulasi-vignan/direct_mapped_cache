`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2025 10:01:05 PM
// Design Name: 
// Module Name: directed_mapped_cache_memory
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


module directed_mapped_cache_memory #(parameter DATA_WIDTH = 32 , ADDR_WIDTH = 8 ,CACHE_SIZE = 16)(
    input clk , rst ,
    input [ADDR_WIDTH -1 :0]addr,
    input [DATA_WIDTH -1: 0]wr_data,
    input mem_write,mem_read,
    output reg [DATA_WIDTH -1 :0]read_data,
    output reg hit

    );
    reg [DATA_WIDTH - 1 : 0]cache_data[CACHE_SIZE - 1 : 0];
    reg [ADDR_WIDTH - ADDR_WIDTH/2 - 1 : 0]tag_array[CACHE_SIZE-1 : 0];
    reg valid_array [CACHE_SIZE-1:0];
    
    wire [ADDR_WIDTH/2 -1 : 0]index;
    wire [ADDR_WIDTH - ADDR_WIDTH /2  -1 : 0 ]tag;
    assign index = addr[ADDR_WIDTH/2 -1 : 0];
    assign tag = addr[ADDR_WIDTH-1 : ADDR_WIDTH/2];
    
    
    integer i ;
    always@(posedge clk)begin 
    if(rst) begin 
        for ( i = 0 ; i < CACHE_SIZE -1 ; i = i + 1)
            valid_array[i] <= 0;
            end 
        end 
        
     
   
    always@(posedge clk )begin 
        if(mem_read)begin 
            if(valid_array[index] && (tag_array[index] == tag))begin 
                read_data <= cache_data[index];
                hit <= 1;
              end else begin 
                read_data = 0 ; 
                hit<= 0;
                end
          end   
      if (mem_write)begin 
        cache_data[index]<= wr_data;
        tag_array[index] <=tag;
        valid_array[index]<= 1;
        end 
    end         
      
endmodule
