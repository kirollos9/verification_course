package graphpakage;
	typedef enum {black,white} color;
	class graphclass;
		rand color image[10][10];
		constraint c {
			foreach(image[i,j])
			image[i][j] dist {white:=20,black:=80};
		}

		function void  printall();
			for(int i=0;i<10;i++)begin
				$display("%p",image[i]);
			end
		endfunction

	endclass 
endpackage