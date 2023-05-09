class test1;
	rand bit [7:0]data;
	rand bit[3:0] address;
	constraint c {address<5;address>2;
		
	}

endclass 
module test_module;
	bit [7:0]data_m;
	bit[3:0] address_m;
	test1 t=new;
	initial begin
	for(int i=0;i<20;i++)begin
		t.randomize();
		data_m=t.data;
		address_m=t.address;
		$display("data=%0d,adress=%0d",data_m,address_m);

	end
	$stop;
end
endmodule 