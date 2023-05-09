vlib work
vlog alupakage.sv interface.sv monitor.sv alu.sv alu_test.sv top.sv +cover -covercells
vsim -voptargs=+acc work.top -cover
add wave *
coverage save top.ucdb -onexit
run -all