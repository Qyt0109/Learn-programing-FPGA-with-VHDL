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
### BaudClockGenerator:
The Baud Clock Generator generates the clock signal required for timing the serial communication. It ensures that data is sampled at the correct rate.
It calculates the baud rate based on the system clock frequency and the desired baud rate.
<img src="https://github.com/Qyt0109/Learn-programing-FPGA-with-VHDL/blob/main/47_UART/ModuleRTLViews/BaudClockGenerator.png">

### Serialiser:
The Serialiser takes parallel data input and converts it into a serial data stream. It serializes the data for transmission over a single data line.
It typically includes a shift register to shift out each bit of the parallel data sequentially.
<img src="https://github.com/Qyt0109/Learn-programing-FPGA-with-VHDL/blob/main/47_UART/ModuleRTLViews/Serialiser.png">

### ShiftRegister:
The Shift Register is used to hold the data temporarily during transmission or reception.
For transmission, it shifts data out serially.
For reception, it receives data serially and shifts it into the register.
<img src="https://github.com/Qyt0109/Learn-programing-FPGA-with-VHDL/blob/main/47_UART/ModuleRTLViews/ShiftRegister.png">

### Synchronizer:
The Synchronizer ensures proper synchronization of the received data with the system clock.
It synchronizes the incoming serial data with the system clock to correctly sample the received bits.
<img src="https://github.com/Qyt0109/Learn-programing-FPGA-with-VHDL/blob/main/47_UART/ModuleRTLViews/Synchronizer.png">

### Receiver's FSM:
The Receiver's FSM controls the behavior of the receiver. It manages the various states of the receiver during reception.
<img src="https://github.com/Qyt0109/Learn-programing-FPGA-with-VHDL/blob/main/47_UART/ModuleRTLViews/Receiver-fsm_state.png">

### Receiver:
The Receiver module is responsible for receiving serial data from an external source.
It typically includes logic for detecting the start bit, receiving the data bits, performing optional parity checks, and detecting the stop bit.
<img src="https://github.com/Qyt0109/Learn-programing-FPGA-with-VHDL/blob/main/47_UART/ModuleRTLViews/Receiver.png">

### Transmitter:
The Transmitter module is responsible for transmitting serial data to an external device.
It typically includes logic for sending data bits serially, optionally generating and sending parity bits, and adding stop bits at the end of each data frame.
<img src="https://github.com/Qyt0109/Learn-programing-FPGA-with-VHDL/blob/main/47_UART/ModuleRTLViews/Transmitter.png">

### TopModule:
The TopModule is the overarching module that combines and connects the various UART modules together to create a complete UART communication system.
<img src="https://github.com/Qyt0109/Learn-programing-FPGA-with-VHDL/blob/main/47_UART/ModuleRTLViews/TopModule.png">


## AES Modules

### Test KeyController:
This module generates all the round keys required and stores them as a LUT for each AES encryption, decryption round.
<img src="https://github.com/Qyt0109/Learn-programing-FPGA-with-VHDL/blob/main/Crypto/AES/RTL%20view%20and%20test/KeyTest0.png">
<img src="https://github.com/Qyt0109/Learn-programing-FPGA-with-VHDL/blob/main/Crypto/AES/RTL%20view%20and%20test/KeyTest1.png">