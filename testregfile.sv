typedef enum {adc0_reg,adc1_reg,temp_sensor0_reg,temp_sensor1_reg,analog_test,digital_test,amp_gain,digital_config} e_reg;
class test_reg_class;
	rand logic reset;
	rand logic write;
	//rand logic[15:0]data;
	rand e_reg e_add;
	rand logic[2:0]add;
	rand logic [15:0]data[1000];
	rand e_reg add_array[1000];
	logic [15:0] data_associative[*];
	constraint c {
		foreach(data[i])
			data[i] inside{[0:65535]};
		reset dist {0:=99,1:=1};
		foreach(add_array[j])
			add_array[j] inside{[adc0_reg:digital_config]};

	}
endclass
module test_reg_file();
	logic clk;
	logic reset;
	logic write;
	logic [15:0] data_in;
	logic [2:0] address;
	logic [15:0] data_out;
	config_reg dut (clk,reset,write,data_in,address,data_out);
	test_reg_class t=new();
	logic [15:0]data[8];
	e_reg add_array[8];
	logic [15:0] data_associative[*];
	initial begin
		clk=0;
		forever
		#1clk=~clk;
	end
	initial begin
		reset=1;
		write=0;
		data_in=0;
		@(negedge clk)
		reset=0;
		assert(t.randomize());
		//declare the associative array with data address
		data_associative[adc0_reg]=16'hFFFF;
		data_associative[adc1_reg]=16'h0;
		data_associative[temp_sensor0_reg]=16'h0;
		data_associative[temp_sensor1_reg]=16'h0;
		data_associative[analog_test]=16'hABCD;
		data_associative[digital_test]=16'h0;
		data_associative[amp_gain]=16'h0;
		data_associative[digital_config]=16'h1;
		rst();
		//first we check the data of reseting
		checkrestartdata(data_associative);
		@(negedge clk);
		write=1;
		assert(t.randomize());
		for(int i=0;i<1000;i++)begin
			data_in=t.data[i];
			checkdata(t.add_array[i],data_in);
		end
		@(negedge clk);
		write=1;
		$display("test the write and reset");
		for(int i=0;i<1000;i++)begin
			assert(t.randomize());
			data_in=t.data[i];
			reset=t.reset;
			write=0;
			checkdata_write_0(t.add_array[i],data_in);
		end

		$stop;

	end
	
	/************************************************
	 * reset task 
	 ************************************************/
	task rst();
		@(negedge clk)
		reset=1;
		@(negedge clk)
		reset=0;
	endtask 
	task checkdata(input e_reg add,input logic [15:0]d);
		address=add;
		@(negedge clk);
		if(d!=data_out)begin
			$display("error address=%p   actual =%0h    expected= %0h",add,data_out,d);
		end
		//else
			//$display("pass address=%p   actual =%0h    expected= %0h",add,data_out,d);
	endtask
	task checkdata_write_0(input e_reg add,input logic [15:0]d);
		address=add;
		@(negedge clk);
		if((d==data_out&&write==0)||(reset==1&&d==data_out))begin
			$display("error address=%p   actual =%0h    expected= %0h,write=%0d,reset=%0d",add,data_out,d,write,reset);
		end
		//else
			//$display("pass address=%p   actual =%0h    expected= %0h",add,data_out,d);
	endtask
	task checkrestartdata(input logic [15:0]data_associative_f[*]);
		checkdata(adc0_reg,data_associative_f[adc0_reg]);
		checkdata(adc1_reg,data_associative_f[adc1_reg]);
		checkdata(temp_sensor0_reg,data_associative_f[temp_sensor0_reg]);
		checkdata(temp_sensor1_reg,data_associative_f[temp_sensor1_reg]);
		checkdata(analog_test,data_associative_f[analog_test]);
		checkdata(digital_test,data_associative_f[digital_test]);
		checkdata(amp_gain,data_associative_f[amp_gain]);
		checkdata(digital_config,data_associative_f[digital_config]);
	endtask
endmodule 