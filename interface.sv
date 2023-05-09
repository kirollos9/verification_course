import testing_pkg::*;
interface alu_if (clk);
input bit clk;
logic[7:0] operand1, operand2;
opcode_e opcode;
logic[7:0] out;
modport TEST (input clk,out,output operand1,operand2,opcode);
modport DUT (input clk,input operand1,input operand2,input opcode,output out);	
modport MONITOR (input operand1,operand2,opcode,clk,out);
endinterface 