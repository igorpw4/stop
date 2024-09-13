# Verifica se a biblioteca 'work' já existe e a deleta se necessário
if {[file isdirectory work]} { 
    vdel -all -lib work 
}

# Cria uma nova biblioteca 'work'
vlib work
vmap work work

# Compila os arquivos VHDL para a biblioteca 'work'
vcom -work work ClockDivisor.vhd
vcom -work work DiviserCounter.vhd
vcom -work work StateMachine.vhd
vcom -work work TopWatch.vhd
vcom -work work tb_Top_Stop_Watch.vhd

# Realiza a simulação do testbench 'tb_top_Stop_Watch' com a opção de otimização e precisão de tempo em nanosegundos
vsim -voptargs=+acc=lprn -t ns work.tb_Top_Stop_Watch

# Suprime os avisos padrão durante a simulação
set StdArithNoWarnings 1
set StdVitalGlitchNoWarnings 1

# Configura as ondas a serem exibidas
do wave.do 

# Roda a simulação por 10000 microsegundos
run 1000 us