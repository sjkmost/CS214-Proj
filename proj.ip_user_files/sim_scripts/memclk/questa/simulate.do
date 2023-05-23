onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib memclk_opt

do {wave.do}

view wave
view structure
view signals

do {memclk.udo}

run -all

quit -force
