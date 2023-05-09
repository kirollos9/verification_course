import testing_pkg::*;
module alu_seq(alu_if.DUT f);
always @(posedge f.clk) begin : proc_
	case (f.opcode)
		ADD: f.out = f.operand1 + f.operand2;
		SUB: f.out = f.operand1 - f.operand2;
		MULT:f.out = f.operand1 * f.operand2; 
		DIV: f.out = f.operand1 / f.operand2;
		default: f.out = 0;
	endcase
end

endmodule