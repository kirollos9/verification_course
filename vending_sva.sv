module vending_sva(clk, rstn, Q_in, D_in, dispense, change);
	input logic clk, rstn, Q_in, D_in;
	input logic dispense, change;
	property a1;
		@(posedge clk) D_in |-> (dispense&change);
	endproperty
	property a2;
		@(posedge clk) $rose(Q_in) |-> ##2 dispense ;
	endproperty
	property a3;
		@(posedge clk) Q_in |-> (!change); 
	endproperty
	asssertion1: assert property(a1);
	asssertion2: assert property(a2);
	asssertion3: assert property(a3);
	c_asssertion1: cover property(a1);
	c_asssertion2: cover property(a2);
	c_asssertion3: cover property(a3);

endmodule