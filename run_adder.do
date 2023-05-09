vlib work
vlog adder.v adder_test.sv adderPakage.sv +cover -covercells
vsim -voptargs=+acc work.adder_test -cover
add wave *
coverage save adder_tests.ucdb -onexit
run -all