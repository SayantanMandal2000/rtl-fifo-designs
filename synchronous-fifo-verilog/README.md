# 🔗 RTL Synchronous FIFO (First-In First-Out) Design 
![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)
![Language: Verilog](https://img.shields.io/badge/language-Verilog-yellow.svg)
![Build: Simulated](https://img.shields.io/badge/build-simulated-green)
![Waveform: Vivado](https://img.shields.io/badge/waveform-GTKwave-blue)
![FSM: Implemented](https://img.shields.io/badge/FSM-Implemented-red)

A synthesizable RTL design of a **Synchronous FIFO (First-In First-Out)** buffer implemented in Verilog, supporting byte-wide data transfer with flow control (`full`, `empty` flags). Designed for FPGA/ASIC-ready environments where safe and ordered data buffering is critical.

---


## 📌 Key Features

- RTL-compliant, synthesizable FIFO design
- Single clock domain (synchronous read/write)
- Byte-wide (`8-bit`) data width
- `full` and `empty` flag logic
- Memory array implementation using dual-port RAM
- Read and write pointer counters
- Registered output data
- Reset handling and clean FSM-free structure
- Includes simulation testbench and GTKWave waveform

---

## 🔧 Design Block Diagram

<p align="center">
  <img src="Sync_FIFO_msb_schema.png" alt="FIFO Block Diagram" width="700"/>
</p>

---

## 💡 Description

This FIFO is implemented for **same-clock domain buffering**, useful for data queuing between two hardware blocks. When `wr_en` is asserted and FIFO is not full, data is written into memory. When `rd_en` is asserted and FIFO is not empty, data is read out.

The **write and read pointers** are updated using synchronous counters. The **full** condition is flagged when the write pointer is one step behind the read pointer (with wrap-around consideration). The **empty** condition is flagged when both pointers are equal.

---

## 📈 Simulation Waveform

<p align="center">
  <img src="Sync_FIFO_waveform.png" alt="FIFO Simulation Waveform" width="800"/>
</p>

The waveform shows:
- FIFO correctly fills with data (`wr_data`) until `full = 1`
- Data is read sequentially from memory via `rd_data`
- `empty = 1` after all data is read

---

## 🧪 Testbench

The testbench performs the following:
- Applies reset
- Writes 8 random data values into FIFO
- Reads back all values while observing status flags
- Verifies FIFO behavior under controlled conditions

---

## 📁 File Structure

| File Name              | Description                           |
|------------------------|---------------------------------------|
| `fifo_sync.v`          | RTL implementation of FIFO            |
| `tb_fifo_sync.v`       | Testbench for simulation              |
| `Sync_FIFO_RTL.png` | RTL block-level diagram           |
| `Sync_FIFO_waveform.png`  | Waveform from GTKWave              |
