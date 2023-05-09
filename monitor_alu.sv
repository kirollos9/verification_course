module monitor(alu_if.MONITOR f);
	initial begin
		$monitor("opcode=%0d ,operand1=%0d ,operand2=%0d",f.opcode,f.operand1,f.operand2);
	end
endmodule