# Build and run procedural examples (1364-1995)

IVERILOG ?= iverilog
VVP ?= vvp

.PHONY: run_always run_task clean

run_always: always_initial
	vvp always_initial

run_task: task_function_1995
	vvp task_function_1995

run: run_always run_task

always_initial: always_initial.v
	$(IVERILOG) -o always_initial always_initial.v

task_function_1995: task_function_1995.v
	$(IVERILOG) -o task_function_1995 task_function_1995.v

clean:
	rm -f always_initial task_function_1995
