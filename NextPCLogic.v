`timescale 1ns / 1ps

module NextPCLogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch);
	// Declare I/O
	output reg [63:0] NextPC;
	input [63:0] CurrentPC, SignExtImm64; // SignExtImm64 is output of Sign Extender from previous lab
	input Branch, ALUZero, Uncondbranch;
	
	// Declare internal wires
	reg [63:0] PCPlusFour, ALUResult;
	
	/**
	 * Describe PCLogic based on diagram in class notes,
	 * including specified delays 
	 */
	 always@(*) begin
		// Calculate both, even though only one result will be used,
		// for realism
		PCPlusFour <= #1 CurrentPC + 4;
		ALUResult <= #2 CurrentPC + SignExtImm64;
		
		if(Uncondbranch || Branch && ALUZero) begin // Simulate MUX with ctrl sig logic
			NextPC <= #1 ALUResult; // Here #1 is MUX delay
//			$display("\tBRANCHING: curPC = 0x%h, signExt = 0x%h, going to 0x%h", CurrentPC, SignExtImm64, ALUResult);
		end else
			NextPC <= #1 PCPlusFour;
	end
endmodule
