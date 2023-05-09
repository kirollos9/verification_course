module memory_test;
	parameter tests=6;
	logic clk;
	logic write;
	logic read;
	logic [7:0] data_in;
	logic [15:0] address;
	logic [8:0] data_out;
	int counter;//count the correct data
	bit[8:0] pop_front_value;//variable to just traverse the data from the queue
	/********************************************************************
	 * dut initaialization
	 *******************************************************************/
	my_mem dut(clk,write,read,data_in,address,data_out);
	/********************************************************************
	 *                              data types 
	 ********************************************************************/
	bit [15:0] address_array[];//dynamic array to randamize the address
	bit [7:0]data_to_write_array[];//dynamic array to the data in 
	bit[8:0]data_read_expect_assoc[int];//associative array as reference the key is the address
	bit[8:0]data_read_queue[$];//queue to read data
	/********************************************************************
	 *                              clock generation
	********************************************************************/

	initial begin
		clk=0;
		forever
		#1 clk=~clk;
	end
	initial begin
		counter=0;
		write=0;
		read=0;
		/*create six tests */
		address_array=new[tests];
		data_to_write_array=new[tests];
		/*initaialize the address array*/
		foreach (address_array[j]) begin
			address_array[j]=$random;
		end
		/*initaialize the data in */
		foreach (address_array[i]) begin
			data_to_write_array[i]=$random;
		end
		/*make the reference associative array */
		for(int i=0;i<address_array.size();i++)begin
			data_read_expect_assoc[address_array[i]]={^data_to_write_array[i],data_to_write_array[i]};
		end
		@(negedge clk);
		write=1;
		for(int i=0;i<6;i++)begin
			@(negedge clk);
			address=address_array[i];
			data_in=data_to_write_array[i];
		end
		@(negedge clk);
		write=0;
		#10;
		@(negedge clk);
		read=1;
		for(int i=0;i<6;i++)begin
			@(negedge clk);
			address=address_array[i];
			check_answer(address);
			data_read_queue.push_back(data_out);
		end
		/**while loop to traverse the data from the queue*/
		while(data_read_queue.size!=0)begin
			pop_front_value=data_read_queue.pop_front();
			$display("data=%h",pop_front_value);
		end
			$display("the correct counter = %d",counter);


		$stop;
	end

	/********************************************************************
	 *                              task to check 
	 ********************************************************************/
	task check_answer(input bit[15:0] address_check);
		@(negedge clk);
		if(data_out!==data_read_expect_assoc[address_check])begin
			$display("%t:input:%h,expected%hbut got%h",$time,address_check,data_read_expect_assoc[address_check],data_out);
			
		end
		else
			counter=counter+1;
	endtask
endmodule