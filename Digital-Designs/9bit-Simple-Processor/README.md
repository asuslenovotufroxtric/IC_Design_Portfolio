# 9-bit Simple Processor

## 1. Project Overview

This project implements a 9-bit simple processor using SystemVerilog.  
The processor is built from fundamental RTL blocks including an 8-register file, an Add/Sub unit, a shared internal bus, a 3-to-8 decoder, and an FSM-based control unit.

The processor supports four basic instructions:

- `mv`: move data between registers
- `mvi`: load immediate data into a register
- `add`: add two register values
- `sub`: subtract two register values

## 2. My Role

I was responsible for 2) A Simple Processor.

My contributions included:

- Integrating the register file, ALU, decoder, bus, and FSM control unit
- Implementing the 9-bit processor datapath in SystemVerilog
- Designing the control sequence for `mv`, `mvi`, `add`, and `sub`
- Running RTL simulation and analyzing waveform results
- Verifying the generated RTL structure using Quartus RTL Viewer

## 3. System Architecture

The processor consists of:

- 8 general-purpose registers: R0–R7
- A shared 9-bit internal bus
- A 9-bit Add/Sub arithmetic unit
- A 3-to-8 decoder for register selection
- A finite state machine control unit
- Temporary registers A, G, and IR

## 4. Datapath Description

The datapath uses a shared bus to transfer data between registers and functional units.

Main data movement:

```text
DIN / Register / ALU Result → Bus → Destination Register
