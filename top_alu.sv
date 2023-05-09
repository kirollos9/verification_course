module top();
	bit clk;
	alu_if f (clk);
	alu_seq D (f);
	alu_test T(f);
	monitor M (f);
	initial begin
		clk=0;
		forever 
		#1 clk=~clk;
	end
endmodule 