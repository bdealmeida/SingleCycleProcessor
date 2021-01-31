`timescale 1ns / 1ps

module RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk);
    // Define I/O
    output  reg [63:0] BusA;
    output  reg [63:0] BusB;
    input   [63:0] BusW;
    input   [4:0] RA, RB, RW;
    input   RegWr;
    input   Clk;
    
    // Have 32 registers array, each 64 bits wide
    reg     [63:0] registers [31:0];
    
    // Init all registers as zero
    integer i;
    initial
        for(i = 0; i < 32; i++)
            registers[i] = 0;
     
    // Always update buses A and B on pos edge following 2 tick delay
    always@ (*) begin
        BusA <= #2 registers[RA];
        //$display("X%0d = 0x%0x", RA, registers[RA]);
        BusB <= #2 registers[RB];
    end
     
    always@ (negedge Clk) begin
        if(RegWr) begin // On falling edge, if RegWr is high update reg RW
            registers[RW] <= #3 BusW; // Delay 3 ticks on write
//            #0 $display("\tUpdating X%0d with val 0x%0x", RW, BusW);
        end
        registers[31] <= #3 0; // Register 31 is always zero
    end
endmodule
