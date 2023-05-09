module associative_test;
bit[23:0] mem[bit[19:0]];
int i=0;
int j=0;
initial begin
	mem[0]=24'ha50400;
	mem[20'h0400]=24'h123456;
    mem[2]=24'h789ABC;
    mem[20'hfffff]=24'h0F1E2D;
    if(mem.first(i))$display("mem[%h]=%h",i,mem[i]);
    while(j<mem.num()-1)begin
    	if(mem.next(i))$display("mem[%h]=%h",i,mem[i]);
    	j++;
    	
    end

end	
endmodule