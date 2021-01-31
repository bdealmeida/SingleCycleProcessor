`define AND   4'b0000
`define OR    4'b0001
`define ADD   4'b0010
`define SUB   4'b0110
`define PassB 4'b0111

`timescale 1ns / 1ps

module ALU(BusW, BusA, BusB, ALUCtrl, Zero);
    
    parameter n = 64;

    output  [n-1:0] BusW;
    input   [n-1:0] BusA, BusB;
    input   [3:0] ALUCtrl;
    output  Zero;
    
    reg     [n-1:0] BusW;
    
    // Always at an input change,
    // calculate BusW with basic ALU functions, selected by the ALUCtrl.
    always @(ALUCtrl or BusA or BusB)
        case(ALUCtrl)
            `AND:   BusW <= #20 BusA & BusB;
            `OR:    BusW <= #20 BusA | BusB;
            `ADD:   BusW <= #20 BusA + BusB;
            `SUB:   BusW <= #20 BusA - BusB;
            `PassB: BusW <= #20 BusB;
        endcase

    assign #1 Zero = BusW ? 0 : 1;
endmodule
