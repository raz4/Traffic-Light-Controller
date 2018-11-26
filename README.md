# Traffic-Light-Controller

Objective: to implement a traffic light controller in Verilog

Input: clock, walk button, sensor under main street

Output: red, yellow, green lights for main and side streets, walk light

The design includes a finite state machine with 5 states which model different traffic light patterns.
The implementation on the FPGA uses 7 LEDs, a switch, and a push button. The LEDs simulate the red,
yellow, green lights for the main and side street as well the walk the light. The switch acts as the
sensor for the main street and the push button controls the walk button. A clock divider was used to
increment the number of seconds elapsed and the states were changed accordingly.
