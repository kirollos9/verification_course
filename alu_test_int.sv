import testing_pkg::*;
class transaction;
	rand opcode_e opcode;
	rand byte operand1;
	rand byte operand2;
	logic clk;
	covergroup covcode;
		opcode_cp:coverpoint opcode
		{
			bins add_sub={ADD,SUB};
			bins ADD_to_sub=(ADD=>SUB);
			illegal_bins illegal_div ={DIV};

		}
		operand1_cp:coverpoint operand1
		{
			bins max_negative={-128}; 
			bins max_positive={127};
			bins zero={0};
			bins other=default; 

		}
		c: cross operand1_cp,opcode_cp{
			bins add_sub_max =binsof(opcode_cp.add_sub)&&binsof(operand1_cp.max_positive) ;
			bins add_sub_min =binsof(opcode_cp.add_sub)&&binsof(operand1_cp.max_negative) ;
			option.weight = 5;
		}

	endgroup
	function new();
		covcode=new();
	endfunction
	function void f();
	 	covcode.sample();
	 endfunction 
endclass 

module alu_test(alu_if.TEST f);
	transaction t =new();
	initial begin
		for(int i=0;i<10000;i++)begin
			@(negedge f.clk);
			t.randomize();
			f.opcode=t.opcode;
			f.operand1=t.operand1;
			f.operand2=t.operand2;
			t.f();
		end
		$stop;
	end
endmodule
