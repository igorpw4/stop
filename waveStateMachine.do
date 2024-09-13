# Suprime os erros e mensagens
onerror {resume}
quietly WaveActivateNextPane {} 0

# Adiciona sinais do testbench
add wave -noupdate /StateMachine_tb/clk
add wave -noupdate /StateMachine_tb/reset
add wave -noupdate /StateMachine_tb/start_btn
add wave -noupdate /StateMachine_tb/stop_btn
add wave -noupdate /StateMachine_tb/split_btn

# Adiciona sinais do módulo StateMachine
add wave -noupdate /StateMachine_tb/uut/reset_out
add wave -noupdate /StateMachine_tb/uut/start_out
add wave -noupdate /StateMachine_tb/uut/stop_out
add wave -noupdate /StateMachine_tb/uut/split_out

# Configurações adicionais de exibição
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {100000 us}
