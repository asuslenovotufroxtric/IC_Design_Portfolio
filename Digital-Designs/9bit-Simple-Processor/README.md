# 9-bit Simple Processor

## 1. Project Overview

This project implements a 9-bit simple processor using SystemVerilog as part of Lab 4: A Simple Processor.

The objective of this experiment is to build a basic CPU by integrating fundamental RTL components, including general-purpose registers, an arithmetic unit, a shared internal bus, a decoder, and an FSM-based control unit.

The processor supports four basic instructions:

* `mv`: move data between registers
* `mvi`: load immediate data into a register
* `add`: add two register values
* `sub`: subtract two register values

This project focuses on Experiment 1 of Lab 4: designing and simulating the simple processor core.

---

## 2. My Role

I was responsible for Experiment 1: Design and Implement a Simple Processor.

My work focused on:

* Building the 9-bit processor core in SystemVerilog
* Integrating the register modules, ALU, decoder, shared bus, and FSM control logic
* Implementing the instruction execution flow for `mv`, `mvi`, `add`, and `sub`
* Simulating the processor behavior in Quartus
* Analyzing waveform results to verify correct instruction execution
* Checking the synthesized RTL structure using Quartus RTL Viewer

---

## 3. System Architecture

The processor is designed around a shared 9-bit internal bus.

Main components:

* 8 general-purpose registers: `R0` to `R7`
* Instruction register: `IR`
* Temporary operand register: `A`
* Result register: `G`
* 9-bit Add/Sub unit
* 3-to-8 decoder for register selection
* FSM-based control unit
* Shared internal bus: `BusWires`

Basic datapath flow:

```text
DIN / Register / ALU Result → BusWires → Destination Register
```

---

## 4. Instruction Format

Each instruction is 9 bits wide:

```text
III_XXX_YYY
```

| Field |  Width | Description          |
| ----- | -----: | -------------------- |
| `III` | 3 bits | Opcode               |
| `XXX` | 3 bits | Destination register |
| `YYY` | 3 bits | Source register      |

Supported instructions:

| Opcode | Instruction  | Operation             |
| ------ | ------------ | --------------------- |
| `000`  | `mv Rx, Ry`  | `Rx = Ry`             |
| `001`  | `mvi Rx, #D` | `Rx = immediate data` |
| `010`  | `add Rx, Ry` | `Rx = Rx + Ry`        |
| `011`  | `sub Rx, Ry` | `Rx = Rx - Ry`        |

---

## 5. FSM Execution Flow

The processor uses a multi-cycle FSM with four timing states:

```text
T0 → T1 → T2 → T3
```

| State | Main Function                                      |
| ----- | -------------------------------------------------- |
| `T0`  | Load instruction from `DIN` into `IR`              |
| `T1`  | Decode instruction and handle simple data movement |
| `T2`  | Execute ALU operation for `add` or `sub`           |
| `T3`  | Write ALU result back to the destination register  |

For simple instructions such as `mv` and `mvi`, the processor can complete the operation earlier. For arithmetic instructions such as `add` and `sub`, additional FSM states are used to load operands, perform calculation, and write back the result.

---

## 6. RTL Modules

| Module      | File               | Description                                            |
| ----------- | ------------------ | ------------------------------------------------------ |
| `regn`      | `rtl/regn.sv`      | 9-bit synchronous register                             |
| `alu`       | `rtl/alu.sv`       | Performs addition and subtraction                      |
| `dec3to8`   | `rtl/dec3to8.sv`   | Selects one of eight registers                         |
| `simpleCPU` | `rtl/simpleCPU.sv` | Top-level processor core with datapath and FSM control |

Recommended repository structure:

```text
9bit-Simple-Processor/
├── README.md
├── rtl/
│   ├── regn.sv
│   ├── alu.sv
│   ├── dec3to8.sv
│   └── simpleCPU.sv
├── sim/
│   ├── wave_simpleCPU.png
│   └── rtl_viewer.png
├── docs/
│   └── instruction_set.md
└── reports/
    └── HPMR_KTS_NHOM8.pdf
```

---

## 7. Simulation Results

The processor was simulated in Quartus using manually applied instruction sequences through input signals such as `DIN`, `Run`, `Clock`, and `Resetn`.

The waveform simulation verifies:

* Loading immediate values using `mvi`
* Moving data between registers using `mv`
* Performing addition using `add`
* Performing subtraction using `sub`
* Correct activation of the `Done` signal after instruction completion

Simulation waveform:

```text
sim/wave_simpleCPU.png
```

---

## 8. RTL Viewer

The RTL Viewer was used to inspect the synthesized hardware structure generated from the SystemVerilog design.

RTL Viewer image:

```text
sim/rtl_viewer.png
```

---

## 9. Tools Used
* SystemVerilog
* Quartus Waveform Simulation
* Quartus RTL Viewer
---

## 10. What I Learned

Through this experiment, I learned how to:

* Design a simple processor using modular RTL blocks
* Build a shared-bus datapath
* Use an FSM to control multi-cycle instruction execution
* Implement basic instruction decoding
* Analyze processor behavior through waveform simulation
* Connect SystemVerilog code with synthesized RTL hardware structure

---

## 11. Report

The full academic report is available in:

```text
reports/HPMR_KTS_NHOM8.pdf
```
