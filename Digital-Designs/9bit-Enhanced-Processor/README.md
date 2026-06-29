# 9-bit Enhanced Processor Subsystem

## 1. System Pipeline & Architecture
The subsystem operates on a multi-cycle execution pipeline controlled by a Finite State Machine (FSM). 
*   **Pipeline Stages:** Fetch ➔ Decode ➔ Execute ➔ Memory Access / Write Back.
*   **Memory Mapping Scheme:** The CPU core communicates with peripheral devices using a centralized address decoder:
    *   `0x000 - 0x07F`: 128-word RAM (Data & Instruction storage).
    *   `0x080 - 0x0FF`: Output LED Registers & Peripherals.

*(Tip for Dat: If you have a block diagram from your report, save it as `architecture.png` in this folder and insert it here using: `![Architecture](./architecture.png)`)*

## 2. Technical Role
**Role: RTL Design & Verification Engineer**
*   Designed the modular Datapath components (ALU, 9-bit Register Files) and the FSM-driven Control Unit using **SystemVerilog**.
*   Implemented the Address Decoding Logic for Memory-Mapping communication between the CPU core, RAM, and LEDs.
*   Wrote the functional Testbench to verify multi-cycle instructions, including conditional jumps and memory operations.

## 3. How to Run & Simulation Setup
*   **EDA Tool:** Intel Quartus Prime (v18.1 or later) / ModelSim.
*   **Steps to reproduce:**
    1. Clone this directory to your local machine.
    2. Open Intel Quartus Prime and import the project files in `RTL-Source/`.
    3. Compile the design (`top.sv`) to verify syntax and check RTL Viewer.
    4. Launch ModelSim, load the testbench `tb_processor.sv`, and run the simulation for `200ns` to observe wave operations.

## 4. Results & Evaluation
*   **Target Frequency:** Successfully synthesized and validated timing constraints at **50 MHz**.
*   **Functional Verification:** Multi-cycle instructions (Arithmetic, Conditional Jumps, Memory Stores) executed flawlessly with zero setup/hold time violations in RTL simulation.
*   **Evaluation:** The system achieved robust signal integrity and correct memory-mapped channel isolation, laying a strong foundation for hardware implementation.
