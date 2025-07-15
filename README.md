#  RTL FIFO Designs in Verilog
![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)
![Language: Verilog](https://img.shields.io/badge/language-Verilog-yellow.svg)
![Build: Simulated](https://img.shields.io/badge/build-simulated-green)
![Waveform: Vivado](https://img.shields.io/badge/waveform-GTKwave-blue)


This repository contains Verilog-based RTL implementations of both **Synchronous** and **Asynchronous (Dual-Clock)** FIFO (First-In First-Out) buffers, widely used in digital systems for temporary data storage, clock domain crossing, and communication between different subsystems.

---

## 📘 Description

🟢 **Synchronous FIFO** – Uses a single clock for both read and write operations.

🔵 **Asynchronous FIFO** – Uses separate, independent clocks for write and read operations.

Both modules are essential components in digital design, especially in **System-on-Chip (SoC)** architectures where data needs to be buffered, streamed, or transferred safely across different modules or clock domains.

These FIFO designs include complete pointer management, flag generation (`full`, `empty`, `overflow`, `underflow`), and simulation testbenches with waveform outputs.

---

## 📖 Theory

### ▶️ What is a FIFO?

A FIFO (First-In First-Out) is a hardware buffer that stores data in the order it was written and ensures it is read out in the same sequence. It is widely used in scenarios like:

- Data streaming between producer and consumer
- Temporary data storage in pipelined systems
- Bridging between two clock domains (asynchronous FIFOs)

---

### 🟢 Synchronous FIFO

- Operates on a **single clock domain**.
- Uses binary counters for **read** and **write pointers**.
- `full` flag is raised when the write pointer catches up to the read pointer (with offset).
- `empty` flag is raised when both pointers are equal.
- Simpler and faster than asynchronous FIFO but limited to systems where both ends share the same clock.

---

### 🔵 Asynchronous FIFO (Dual Clock)

- Operates on **two independent clocks** (`wr_clk` and `rd_clk`).
- Uses **Gray code** conversion for pointer synchronization across clock domains.
- Synchronizers (`sync_w2r`, `sync_r2w`) are used to safely pass pointers between domains.
- Handles clock domain crossing (CDC) using safe techniques to prevent metastability.
- More complex, but essential when interfacing modules running on different clocks.

---

### ⏱️ Flag Logic

- `full` is asserted when the next write would overwrite unread data.
- `empty` is asserted when there is no data left to read.
- `overflow` and `underflow` are optional flags for debug or protection logic.
- Pointers are compared using binary or Gray-coded values depending on FIFO type.

---

These designs are built for clarity, modularity, and synthesis compatibility for FPGA/ASIC workflows.

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

## ⏱️ Flag Logic

- `full`: Write pointer is one step behind the (inverted MSBs of) synchronized read pointer
- `empty`: Read pointer matches the synchronized write pointer
- Flags are computed using either binary or Gray-coded comparison logic depending on the architecture

---


## 📌 Project Highlights

| Feature                     | Synchronous FIFO                  | Asynchronous FIFO              |
|----------------------------|-----------------------------------|-------------------------------|
| Clock Domains              | Single clock (`clk`)              | Dual clocks (`w_clk`, `r_clk`)|
| Pointer Format             | Binary                            | Gray code                     |
| Synchronization            | Not required                      | Required (`sync_r2w`, `sync_w2r`) |
| Use Case                   | Same-clock systems                | CDC (Clock Domain Crossing)   |
| Status Flags               | `full`, `empty`                   | `full`, `empty`               |
| Extras                     | Registered output, clean counters | Gray code + synchronizers     |
| Testbench                  | Included                          | Included                      |
| Waveform                   | GTKWave compatible                | GTKWave compatible            |

---

## 🔧 RTL Block Diagrams

### Synchronous FIFO
<p align="center">
  <img src="https://github.com/SayantanMandal2000/rtl-fifo-designs/blob/main/synchronous-fifo-verilog/images/Sync_FIFO_RTL.png" alt="Synchronous FIFO RTL Diagram" width="700"/>
</p>

### Asynchronous FIFO (Dual Clock)
<p align="center">
  <img src="https://github.com/SayantanMandal2000/rtl-fifo-designs/blob/main/asynchronous-dual-clock-fifo/sim/Async_FIFO_RTL.png" alt="Asynchronous FIFO RTL Diagram" width="700"/>
</p>

---

## 🧪 Testbench Support

Both designs are fully testbench-driven.  
The testbenches include:
- Reset and initialization sequences
- Data push into FIFO (`wr_en`)
- Data read from FIFO (`rd_en`)
- Observation of status flags under different scenarios

  
Use [GTKWave](http://gtkwave.sourceforge.net/) to inspect `vcd` waveform outputs.

---

## 📁 Folder Structure

```bash
rtl-fifo-designs/
│
├── synchronous-fifo-verilog/
│   ├── fifo_sync.v
│   ├── tb_fifo_sync.v
│   └── images/
│       └── Sync_FIFO_RTL.png
│       └── Sync_FIFO_waveform.png
│
├── asynchronous-dual-clock-fifo/
│   ├── async_fifo.v
│   ├── fifo_mem.v
│   ├── full.v
│   ├── empty.v
│   ├── sync_r2w.v
│   ├── sync_w2r.v
│   ├── tb_async_fifo.v
│   └── sim/
│       └── Async_FIFO_RTL.png
│       └── Async_FIFO_waveform.png
