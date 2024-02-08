# Learn programing FPGA with VHDL
Learn programing FPGA with VHDL, builds basic modules and components. FPGA based UART Tx Rx

1. Reading a switch input and driving an LED output
2. Simple State Machine which reacts to user input and drives a number of LEDs
3. Synchronising and de-bouncing a Switch Input.
4. Generating a PWM output.
5. Designing a Shift Register.
6. 4 Digit 7-Segment display for counting the number of push button activations
7. UART module & State machine for echoing back characters received from a PC over RS232

## UART Module RLT Views
### BaudClockGenerator
<img src="https://github.com/Qyt0109/Learn-programing-FPGA-with-VHDL/blob/main/47_UART/ModuleRTLViews/BaudClockGenerator.png">

### Serialiser
<img src="https://github.com/Qyt0109/Learn-programing-FPGA-with-VHDL/blob/main/47_UART/ModuleRTLViews/Serialiser.png">

### ShiftRegister
<img src="https://github.com/Qyt0109/Learn-programing-FPGA-with-VHDL/blob/main/47_UART/ModuleRTLViews/ShiftRegister.png">

### Synchronizer
<img src="https://github.com/Qyt0109/Learn-programing-FPGA-with-VHDL/blob/main/47_UART/ModuleRTLViews/Synchronizer.png">

### Receiver's FSM
<img src="https://github.com/Qyt0109/Learn-programing-FPGA-with-VHDL/blob/main/47_UART/ModuleRTLViews/Receiver-fsm_state.png">

### Receiver
<img src="https://github.com/Qyt0109/Learn-programing-FPGA-with-VHDL/blob/main/47_UART/ModuleRTLViews/Receiver.png">

### Transmitter
<img src="https://github.com/Qyt0109/Learn-programing-FPGA-with-VHDL/blob/main/47_UART/ModuleRTLViews/Transmitter.png">

### TopModule
<img src="https://github.com/Qyt0109/Learn-programing-FPGA-with-VHDL/blob/main/47_UART/ModuleRTLViews/TopModule.png">
