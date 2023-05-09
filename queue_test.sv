module queue_test;
int q[$];
int j;
initial begin
j=1;
q={0,2,5};
q.insert(1,j);
//insert j in position 1
$display("q=%p",q);
q.delete(1);
//delete index 1
$display("q=%p",q);
q.push_front(7);
//push 7 in front 
$display("q=%p",q);
q.push_back(9);
//push 9 back
$display("q=%p",q);
j=q.pop_back();
//pop back
$display("j=%0d ,q=%p",j,q);
j=q.pop_front();
$display("j=%0d ,q=%p",j,q);
q.reverse();
$display("q=%p",q);
q.sort();
$display("q=%p",q);
q.reverse();
$display("q=%p",q);
q.shuffle();
$display("q=%p",q);


end


endmodule