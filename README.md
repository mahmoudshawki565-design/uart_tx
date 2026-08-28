# UART Transmitter

## Description

A modular UART Transmitter designed and implemented using Verilog HDL. The design converts 8-bit parallel data into a serial UART frame and supports optional Even and Odd parity.

## Features

- 8-bit parallel data input
- Start bit generation
- LSB-first serial transmission
- Optional parity bit
- Even and Odd parity support
- Stop bit generation
- BUSY signal for transmission status
- FSM-based control
- Parameterized data width

## System Architecture

The UART Transmitter consists of four main modules:

- UART Controller
- Serializer
- Parity Calculator
- MUX

The UART Controller manages the transmission sequence and generates the required control signals.

## UART Frame

The transmitted frame consists of:

Start Bit → Data Bits → Parity Bit → Stop Bit

The parity bit is optional depending on the PAR_EN input.

## Module Description

### UART Controller

Controls the transmission process using four states:

- START
- DATA
- PARITY
- STOP

### Serializer

Converts the parallel input data into serial data using LSB-first transmission.

### Parity Calculator

Generates the parity bit based on the selected parity type:

- Even Parity
- Odd Parity

### MUX

Selects the appropriate signal to drive the TX_OUT output according to the current controller state.

## I/O Ports

| Port | Direction | Description |
|------|-----------|-------------|
| CLK | Input | Clock signal |
| RSTN | Input | Active-low reset |
| P_DATA | Input | Parallel input data |
| DATA_VALID | Input | Indicates valid input data |
| PAR_EN | Input | Enables parity |
| PAR_TYP | Input | Selects Even/Odd parity |
| TX_OUT | Output | Serial UART output |
| BUSY | Output | Transmission status |

## Verification

The design was verified using:

- ModelSim Simulation
- Testbench Verification
- Complete Waveform Analysis
- Quartus Prime RTL Synthesis
- Static Timing Analysis (STA)

Different data patterns were tested with parity enabled and disabled to verify the correct UART transmission sequence.

## Project Files

```text
RTL/
Testbench/
Simulation/
Synthesis/
Presentation/
