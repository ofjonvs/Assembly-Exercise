# set the microcontroller; This is the one used in the
# circuit playground.  To use a different controller,
# pins_arduino.h in this directory may need to be replaced.

MCU=atmega32u4

RUN_AVR=simavr

# if not using grace, vagrant or the provisioning steps in the
# Vagrantfile to install a modified simavr globally, use a
# relative path to the run_avr program.

# RUN_AVR=../../circuit-playground/simavr/simavr/run_avr --mcu $(MCU) 

just_compile: exercise

# The following rule takes a .S file, assembles it, and
# links it with a compiled serial.c, which gives printf /
# putchar somemplace to go.

%: %.S 
	avr-gcc -g -mmcu=$(MCU) $< serial.c -o $@

# The .gdb rule starts a simulator and runs the avr-gdb debugger
%.gdb: %
	@echo "adding add-auto-load-safe-path .gdbinit to ~/.gdbinit configuration file"
	grep "add-auto-load-safe-path .gdbinit" ~/.gdbinit || echo "add-auto-load-safe-path .gdbinit" >> ~/.gdbinit
	$(RUN_AVR) -g $* & avr-gdb $*

# the .run rule starts a simulator and executes the instructions.  If the
# code does not end with "cli\n sleep", the simulator will continue to execute
# the code.  The library wrapper has an infinite loop that would otherwise
# execute after main().
%.run: %
	$(RUN_AVR) $*

#	avr-as -mmcu=atmega128 --gstabs -o $@ $<

exercise: exercise_driver.c exercise.S
	avr-gcc -g -mmcu=$(MCU) $^ serial.c -o $@


clean:
	rm -f exercise

