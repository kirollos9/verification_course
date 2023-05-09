import  graphpakage::*; 
module gpraphmodule;
	graphclass g = new;
	initial begin
	g.randomize();
	g.printall();
end
endmodule 