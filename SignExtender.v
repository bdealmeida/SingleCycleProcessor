/**
 * When ctrl is 000, output I-Type
 * When ctrl is 001, output D-Type
 * When ctrl is 010, output B
 * When ctrl is 011, output CBZ
 * When ctrl is 100, output MOVZ
 */
module SignExtender(BusImm, Imm26, Ctrl);
    // Define I/O
    output reg	[63:0] BusImm;
    input	[25:0] Imm26;
    input	[2:0] Ctrl;

    // Describe sign extender, 
    // Each type's equation based on location of immediate/addr in instr
    // Addresses (B & CBZ) are also left shifted by 2 bits
    always@(*)
	case(Ctrl)
	    3'b000: BusImm = {52'b0, Imm26[21:10]}; // I-Type
	    3'b001: BusImm = {{55{Imm26[20]}}, Imm26[20:12]}; // D-Type
	    3'b010: begin 
		BusImm = {{36{Imm26[25]}}, Imm26[25:0], 2'b00}; // B
//		#0 $display("\tB found, passing 0x%h to BusImm", BusImm);
	    end
	    3'b011: begin
		BusImm = {{43{Imm26[23]}}, Imm26[23:5], 2'b00}; // CBZ
//		#0 $display("\tCBZ found, passing 0x%h to BusImm", BusImm);
	    end
	    3'b100: begin
		BusImm = {48'b0,Imm26[20:5]};
//		#0 $display("\tMOVZ found, passing 0x%h", BusImm);
	    end
	endcase
endmodule

