module test_dynamic_array;
int dyn_arr1[],dyn_arr2[];
initial begin
	dyn_arr2='{9,1,8,3,4,4};
	dyn_arr1=new[6];
	dyn_arr1='{0,1,2,3,4,5};
	foreach(dyn_arr1[i])begin
		$display("dyn_arr1[%0d]=%0d",i,dyn_arr1[i]);
	end
	$display("dyn_arr1_size=%0d",dyn_arr1.size());
	dyn_arr1.delete();

	dyn_arr2.reverse();
	$display("dyn_arr2=%p",dyn_arr2);
	dyn_arr2.sort();
	$display("dyn_arr2=%p",dyn_arr2);
	dyn_arr2.reverse();
	$display("dyn_arr2=%p",dyn_arr2);
	dyn_arr2.shuffle();
	$display("dyn_arr2=%p",dyn_arr2);



end 


endmodule