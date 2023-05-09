import  adderpakage::*; 
module adder_test();
logic clk;
logic reset;
logic signed [3:0] A;	
logic signed [3:0] B;	
logic signed [4:0] C;
logic signed [4:0] c_expected;
adder a1 (clk,reset,A,B,C);
covergroup covcode ;
		A_covgrp:coverpoint A iff (!reset)
		{
			bins data_0={ZERO};
			bins data_max={MAXPOS};
			bins data_min= {MAXNEG};
			bins data_0max=(ZERO=>MAXPOS);
			bins data_maxmin=(MAXPOS=>MAXNEG);
			bins data_minmax=(MAXNEG=>MAXPOS);
			bins data_default=default;

		}
		B_covgrp:coverpoint B iff (!reset)
		{
			bins data_0={ZERO};
			bins data_max={MAXPOS};
			bins data_min= {MAXNEG};
			bins data_0max=(ZERO=>MAXPOS);
			bins data_maxmin=(MAXPOS=>MAXNEG);
			bins data_minmax=(MAXNEG=>MAXPOS);
			bins data_default=default;

		}
		
	endgroup
adder_class a=new();
covcode ck = new();
initial begin
	clk=0;
	forever
	#1clk=~clk;
end
initial begin
	A=0;
	B=0;
	c_expected=A+B;
	reset=1;
	#20;
	for(int i=0;i<1000;i++)begin
		assert(a.randomize());
		A=a.A;
		B=a.B;
		reset=a.rst;
		ck.sample();
		check(A+B);

	end
	#10;
	$stop;
	
end
	task check(input [4:0]c_expected);
	@(negedge clk);
	if(C!==c_expected&&reset==0) $display("error,A=%0d,B=%0d,cexpected=%0d,c=%0d,reset=%d",A,B,c_expected,C,reset);
	else $display("pass");
endtask
endmodule 