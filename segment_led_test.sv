module segment_test;
	localparam tests=100;
	reg [3:0] hexa;
	reg clk;
	wire a,b,c,d,e,f,g;
	//dut
	segment_LED_display dut (hexa, clk, a, b, c, d, e, f, g);
	///internal arrays and vectors used to check the design 
	bit[6:0] data_read_expct_assoc[int];
	bit[3:0] data_to_write_array[];
	logic [6:0] data_out;
	assign data_out={a,b,c,d,e,f,g};
	initial begin
		clk=0;
		forever
		#1 clk=~clk;
	end
	initial begin
		data_read_expct_assoc[4'h0] = 7'b111_1110;
		data_read_expct_assoc[4'h1] = 7'b011_0000;
		data_read_expct_assoc[4'h2] = 7'b110_1101;
		data_read_expct_assoc[4'h3] = 7'b111_1001;
		data_read_expct_assoc[4'h4] = 7'b011_0011;
		data_read_expct_assoc[4'h5] = 7'b101_1011;
		data_read_expct_assoc[4'h6] = 7'b101_1111;
		data_read_expct_assoc[4'h7] = 7'b111_0000;
		data_read_expct_assoc[4'h8] = 7'b111_1111;
		data_read_expct_assoc[4'h9] = 7'b111_1011;
		data_read_expct_assoc[4'hA] = 7'b111_0111;
		data_read_expct_assoc[4'hB] = 7'b001_1111;
		data_read_expct_assoc[4'hC] = 7'b100_1110;
		data_read_expct_assoc[4'hD] = 7'b011_1101;
		data_read_expct_assoc[4'hE] = 7'b100_1111;
		data_read_expct_assoc[4'hF] = 7'b100_0111;
		//intialize the dynamic array
		data_to_write_array=new[tests];
		//initial the dynamic with random value
		foreach(data_to_write_array[i])begin
			data_to_write_array[i]=$random;
		end
		//
		foreach(data_to_write_array[j])begin
		@(negedge clk);
		hexa=data_to_write_array[j];
		check_answer(hexa);	
		end
		$display("the tests pass");
		$stop;
	end
	task check_answer(input bit[3:0] hexa_seg);
		@(negedge clk);
		if(data_out!=data_read_expct_assoc[hexa_seg])$display("notpasssssssss");
	endtask
endmodule