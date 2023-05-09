module test;
	logic clk, rstn, Q_in, D_in;
	logic dispense, change;
	vending_machine dut(clk, rstn, Q_in, D_in, dispense, change);
	bind vending_machine  vending_sva sva_instance (clk, rstn, Q_in, D_in, dispense, change);
	initial begin
		clk=0;
		forever #1 clk=~clk;
	end
	initial begin
		rstn=0;
		#10;
		rstn=1;
		Q_in=0;
		D_in=1;
		#100;
		Q_in=1;
		D_in=0;
		#100;

		
		$stop;

	end
endmodule 