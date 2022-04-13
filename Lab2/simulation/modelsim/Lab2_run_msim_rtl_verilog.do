transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Aidan/Documents/DigLabs/Lab2 {C:/Users/Aidan/Documents/DigLabs/Lab2/HexTo7Seg.v}
vlog -vlog01compat -work work +incdir+C:/Users/Aidan/Documents/DigLabs/Lab2/output_files {C:/Users/Aidan/Documents/DigLabs/Lab2/output_files/DisplayDriver.v}
vlog -vlog01compat -work work +incdir+C:/Users/Aidan/Documents/DigLabs/Lab2/output_files {C:/Users/Aidan/Documents/DigLabs/Lab2/output_files/Lab2.v}
vlog -vlog01compat -work work +incdir+C:/Users/Aidan/Documents/DigLabs/Lab2/output_files {C:/Users/Aidan/Documents/DigLabs/Lab2/output_files/Demux1x4To4x4.v}

vlog -vlog01compat -work work +incdir+C:/Users/Aidan/Documents/DigLabs/Lab2 {C:/Users/Aidan/Documents/DigLabs/Lab2/SevenSegTB.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  SevenSegTB

add wave *
view structure
view signals
run -all
