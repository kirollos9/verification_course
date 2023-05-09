package adderpakage;
	typedef enum {MAXPOS=7,ZERO=0,MAXNEG=-8} e_reg;
	class adder_class;
		rand e_reg e_A_b;
		rand logic signed [3:0] A_B_other;
		rand logic signed [3:0] A;
		rand logic signed [3:0] B;
		rand logic rst;
		constraint c {
			rst dist {1:=1,0:=99};
			A_B_other!=e_A_b;
			e_A_b dist{MAXPOS:=1,ZERO:=1,MAXNEG:=1};
			A dist {e_A_b:=80,A_B_other:=20};
			B dist {e_A_b:=80,A_B_other:=20};

		}

	endclass 
endpackage