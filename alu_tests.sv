module alu_test;
logic clk;
logic reset;
logic  [1:0] Opcode;	
logic  signed [3:0] A;	
logic  signed [3:0] B;
logic signed [4:0] C; 
logic signed [4:0] c_expected;
ALU_4_bit alu (clk,reset,Opcode,A,B,C);
task rst1();
	@(negedge clk)
	reset=1;
	@(negedge clk)
	reset=0;
endtask
task check(input [4:0]c_expected);
@(negedge clk);	
if(C!==c_expected) $display("error_in_thealu");
else $display("pass");
endtask
initial begin
rst1();//check the rest at beginning
A=7;B=7;Opcode=2'b00;c_expected=A+B;check(c_expected);//test the add
A=-8;B=-8;Opcode=2'b01;c_expected=A-B; check(c_expected);//test the subtract
A=0;B=0;Opcode=2'b10;c_expected=~A;check(c_expected);//tets the invert
A=1;B=4'b1000;Opcode=2'b11;c_expected=|B;check(c_expected);//test the reduction on B
A=4'b1000;B=4'b0000;Opcode=2'b00;c_expected=A+B; check(c_expected);//test the toggle
A=4'b0111;B=4'b0000;Opcode=2'b00;c_expected=A+B; check(c_expected);	//test the toggling
rst1();//check the rest at end
#50;
$stop;
end
initial begin
clk=0;
forever #1 clk=~clk; 
end
initial begin 
end
endmodule
