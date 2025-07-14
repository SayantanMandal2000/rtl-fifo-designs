#  RTL FIFO Designs in Verilog
![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)
![Language: Verilog](https://img.shields.io/badge/language-Verilog-yellow.svg)
![Build: Simulated](https://img.shields.io/badge/build-simulated-green)
![Waveform: Vivado](https://img.shields.io/badge/waveform-GTKwave-blue)
![FSM: Implemented](https://img.shields.io/badge/FSM-Implemented-red)

This repository contains Verilog-based RTL implementations of both **Synchronous** and **Asynchronous (Dual-Clock)** FIFO (First-In First-Out) buffers, widely used in digital systems for temporary data storage, clock domain crossing, and communication between different subsystems.

---

## 📌 Project Highlights

- ✅ **Synchronous FIFO**
  - Single-clock domain read/write
  - Parameterizable data width and depth
  - Clean flag logic (`full`, `empty`)
  - Pipelined read/write pointers
  - Testbench and waveform simulation

- ✅ **Asynchronous FIFO**
  - Dual-clock domain (independent write and read clocks)
  - Gray code pointer synchronization
  - `full`, `empty`, `overflow`, `underflow`, `valid` flag generation
  - Safe and robust cross-domain design
  - Integrated modules like `convert_b2g`, `convert_g2b`, and synchronizers

---

## 🔧 RTL Block Diagrams

### Synchronous FIFO
<p align="center">
  <img src="https://github.com/SayantanMandal2000/rtl-fifo-designs/blob/main/synchronous-fifo-verilog/images/Sync_FIFO_RTL.png" alt="Synchronous FIFO RTL Diagram" width="700"/>
</p>

### Asynchronous FIFO (Dual Clock)
<p align="center">
  <img src="Async_FIFO_Block.png" alt="Asynchronous FIFO RTL Diagram" width="700"/>
</p>

---

## 🧪 Testbench Support

Both designs are fully testbench-driven.  
The testbenches include:
- Reset and initialization sequences
- Data push into FIFO (`wr_en`)
- Data read from FIFO (`rd_en`)
- Observation of status flags under different scenarios
