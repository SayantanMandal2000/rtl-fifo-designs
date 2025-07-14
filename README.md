#  RTL FIFO Designs in Verilog

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
  <img src="Sync_FIFO_msb_schema.png" alt="Synchronous FIFO Diagram" width="700"/>
</p>

### Asynchronous FIFO (Dual Clock)
<p align="center">
  <img src="Async_FIFO_Block.png" alt="Asynchronous FIFO Block" width="700"/>
</p>
