/**
 * When ctrl is 00, output I-Type
 * When ctrl is 01, output D-Type
 * When ctrl is 10, output B
 * When ctrl is 11, output CBZ
 */
module SignExtender(BusImm, Imm26, Ctrl);
    // Define I/O
    output reg	[63:0] BusImm;
    input	[25:0] Imm26;
    input	[1:0] Ctrl;

    // Describe sign extender, 
    // Each type's equation based on location of immediate/addr in instr
    // Addresses (B & CBZ) are also left shifted by 2 bits
    always@(*)
	case(Ctrl)
	    2'b00: BusImm = {52'b0, Imm26[21:10]}; // I-Type
	    2'b01: BusImm = {{55{Imm26[20]}}, Imm26[20:12]}; // D-Type
	    2'b10: BusImm = {{36{Imm26[25]}}, Imm26[25:0], 2'b00}; // B
	    2'b11: BusImm = {{43{Imm26[23]}}, Imm26[23:5], 2'b00}; // CBZ
	endcase
endmodule

