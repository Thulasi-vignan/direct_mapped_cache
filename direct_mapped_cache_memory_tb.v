`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2025 10:41:25 AM
// Design Name: 
// Module Name: direct_mapped_cache_memory_tb
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


module direct_mapped_cache_memory_tb();
    parameter DATA_WIDTH = 32;
    parameter ADDR_WIDTH = 8;
    parameter CACHE_SIZE = 16;
    
    reg clk ,rst;
    reg [DATA_WIDTH - 1 : 0]wr_data;
    reg [ADDR_WIDTH - 1 : 0]addr;
    reg mem_write,mem_read;
    wire [DATA_WIDTH - 1 : 0]read_data;
    wire hit;
    
    directed_mapped_cache_memory #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH),.CACHE_SIZE(CACHE_SIZE)) uut (.clk(clk),.rst(rst),.wr_data(wr_data),.addr(addr),.mem_read(mem_read),.mem_write(mem_write),.read_data(read_data),.hit(hit));
    
   
    always #5 clk = ~clk;
    
    initial begin 
      clk = 0;
      rst = 1;
      addr = 0;
      wr_data = 0;
      mem_read = 0;
      mem_write = 0;
      
      #10 rst = 0;
     // test case 1 :write to cache and then read from it 
      
      addr = 8;
      wr_data = 32'h12345678;
      mem_write = 1;
      #10 mem_write = 0;
      
      // read from addr and expect cache hit 
      mem_read = 1;
      addr = 8;
      
      #10 
      if(read_data == 32'h12345678 && hit )
        $display ("Test case  1 passed : cache hit and correct data ");
      else 
        $display ("Test case 1 failed : cache miss or incorrect data");
        
     mem_read = 0;
     
     //Test case 2 : read from address 4 and it should be a miss 
        addr = 4 ;
        mem_read = 1 ;
        #10 
            if (!hit)
                $display ("Test case 2 passed : Cache missed");
             else 
                $display ("Test case 2 failed : Cache hit unexpected");
                
         mem_read = 0;
        
        
        // wrire new data and verify cache update 
        
        addr = 8;
        wr_data = 32'hDEADBEEF;
        mem_write = 1;
        #10 ;
        mem_write = 0;
        
        
        // read back the updated data from address 8
        
        mem_read =1; 
        #10 ;
          if(read_data == 32'hDEADBEEF && hit )
             $display ("Test case  3 passed : cache updated and hit  ");
        else 
             $display ("Test case 3 failed : Cache not updated correctly");
        
     mem_read = 0; 
     
     $stop;
     
     end 
  
endmodule
