typedef enum {adc0_reg,adc1_reg,temp_sensor0_reg,temp_sensor1_reg,analog_test,digital_test,amp_gain,digital_config} e_reg;
module send_developer;
	logic clk;
	logic reset;
	logic write;
	logic [15:0] data_in;
	logic [2:0] address;
	logic [15:0] data_out;
	config_reg dut (clk,reset,write,data_in,address,data_out);
	e_reg e_add;
	initial begin
		clk=0;
		forever
		#1clk=~clk;
	end
	initial begin
		@(negedge clk); 
		reset=1;
		//first bug at reset
		@(negedge clk); 
		e_add=analog_test;
		address=e_add;
		@(negedge clk); 
		$display("reset=%0d,write=%0d,address = %p,actual=%0h,expected=abcd,",reset,write,e_add,data_out);
		//second bug 
		@(negedge clk); 
		reset=0;
		write=1;
		e_add=adc1_reg;
		address=e_add;
		data_in=16'h4acc;
		@(negedge clk); 
		$display("reset=%0d,write=%0d,address = %p,actual=%0h,expected=%0h,",reset,write,e_add,data_out,data_in);
		//3 bug
		@(negedge clk);
		e_add=adc0_reg;
		address=e_add;
		data_in=16'h11bc;
		@(negedge clk); 
		$display("reset=%0d,write=%0d,address = %p,actual=%0h,expected=%0h,",reset,write,e_add,data_out,data_in);
		//4
		@(negedge clk);
		e_add=digital_test;
		address=e_add;
		data_in=16'h980d;
		@(negedge clk); 
		$display("reset=%0d,write=%0d,address = %p,actual=%0h,expected=%0h,",reset,write,e_add,data_out,data_in);
		//5
		@(negedge clk);
		e_add=amp_gain;
		address=e_add;
		data_in=16'h34f3;
		@(negedge clk); 
		$display("reset=%0d,write=%0d,address = %p,actual=%0h,expected=%0h,",reset,write,e_add,data_out,data_in);
		//6
		@(negedge clk);
		e_add=temp_sensor0_reg;
		address=e_add;
		data_in=16'hf1a0;
		@(negedge clk); 
		$display("reset=%0d,write=%0d,address = %p,actual=%0h,expected=%0h,",reset,write,e_add,data_out,data_in);
		//7
		@(negedge clk);
		e_add=digital_config;
		address=e_add;
		data_in=16'h9100;
		@(negedge clk); 
		$display("reset=%0d,write=%0d,address = %p,actual=%0h,expected=%0h,",reset,write,e_add,data_out,data_in);
		$stop;


	end
endmodule