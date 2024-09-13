# Suprime os erros e mensagens
onerror {resume}
quietly WaveActivateNextPane {} 0

# Adiciona sinais do testbench
add wave -noupdate /tb_top_Stop_Watch/clk_in
add wave -noupdate /tb_top_Stop_Watch/rst_in
add wave -noupdate /tb_top_Stop_Watch/start_btn
add wave -noupdate /tb_top_Stop_Watch/stop_btn
add wave -noupdate /tb_top_Stop_Watch/split_btn

# Adiciona sinais do módulo top_Stop_Watch
add wave -noupdate -radix decimal /tb_top_Stop_Watch/DUT/hour_count_high
add wave -noupdate -radix decimal /tb_top_Stop_Watch/DUT/hour_count_low
add wave -noupdate -radix decimal /tb_top_Stop_Watch/DUT/minute_count_high
add wave -noupdate -radix decimal /tb_top_Stop_Watch/DUT/minute_count_low
add wave -noupdate -radix decimal /tb_top_Stop_Watch/DUT/second_count_high
add wave -noupdate -radix decimal /tb_top_Stop_Watch/DUT/second_count_low
add wave -noupdate -radix decimal /tb_top_Stop_Watch/DUT/hundredth_count_high
add wave -noupdate -radix decimal /tb_top_Stop_Watch/DUT/hundredth_count_low

# Adiciona sinais do módulo StateMachine
add wave -noupdate /tb_top_Stop_Watch/DUT/state_machine_inst/start_out
add wave -noupdate /tb_top_Stop_Watch/DUT/state_machine_inst/stop_out
add wave -noupdate /tb_top_Stop_Watch/DUT/state_machine_inst/reset_out
add wave -noupdate /tb_top_Stop_Watch/DUT/state_machine_inst/split_out

# Adiciona o estado da StateMachine
add wave -noupdate /tb_top_Stop_Watch/DUT/state_machine_inst/current_state

# Adiciona sinais do módulo CentisecondCounter
add wave -noupdate /tb_top_Stop_Watch/DUT/centisecond_counter_inst/pulse_out

# Adiciona sinais do módulo DiviserCounter
add wave -noupdate -radix decimal /tb_top_Stop_Watch/DUT/diviser_counter_inst/hour_count_high
add wave -noupdate -radix decimal /tb_top_Stop_Watch/DUT/diviser_counter_inst/hour_count_low
add wave -noupdate -radix decimal /tb_top_Stop_Watch/DUT/diviser_counter_inst/minute_count_high
add wave -noupdate -radix decimal /tb_top_Stop_Watch/DUT/diviser_counter_inst/minute_count_low
add wave -noupdate -radix decimal /tb_top_Stop_Watch/DUT/diviser_counter_inst/second_count_high
add wave -noupdate -radix decimal /tb_top_Stop_Watch/DUT/diviser_counter_inst/second_count_low
add wave -noupdate -radix decimal /tb_top_Stop_Watch/DUT/diviser_counter_inst/hundredth_count_high
add wave -noupdate -radix decimal /tb_top_Stop_Watch/DUT/diviser_counter_inst/hundredth_count_low

# Adiciona sinais internos do DiviserCounter (contadores)
add wave -noupdate /tb_top_Stop_Watch/DUT/diviser_counter_inst/hundreds
add wave -noupdate /tb_top_Stop_Watch/DUT/diviser_counter_inst/seconds
add wave -noupdate /tb_top_Stop_Watch/DUT/diviser_counter_inst/minutes
add wave -noupdate /tb_top_Stop_Watch/DUT/diviser_counter_inst/hours

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
WaveRestoreZoom {0 ns} {10000 us}
