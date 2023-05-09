module vending_machine(clk, rstn, Q_in, D_in, dispense, change);
	parameter WAIT = 2'b00;
	parameter Q_25 = 2'b01;
	parameter Q_50 = 2'b11;
	input clk, rstn, Q_in, D_in;
	output reg dispense, change;

	reg [1:0] cs, ns; // cs >> current state, ns >> next state

	//Next State Logic
	always @(cs, Q_in, D_in) begin
		case (cs)
			WAIT: 
				if (Q_in)
					ns = Q_25;
				else 
					ns = WAIT;

			Q_25:
				if (Q_in)
					ns = Q_50;
				else 
					ns = Q_25;

			Q_50:
				if (Q_in)
					ns = WAIT;
				else 
					ns = Q_50;

			default: 	ns = WAIT;
		endcase
	end

	//State Memory
	always @(posedge clk or negedge rstn) begin
		if(~rstn)
			cs <= WAIT;
		else
			cs <= ns;
	end

	//Output Logic
	always @(cs, Q_in, D_in) begin 
		if ( (cs == WAIT && D_in == 1'b1) || (cs == Q_50 && Q_in == 1'b1) )	
			dispense = 1'b1;
		else 
			dispense = 1'b0;

		if (cs == WAIT && D_in == 1'b1) 
			change = 1'b1;
		else	
			change = 1'b0;
	end

endmodule