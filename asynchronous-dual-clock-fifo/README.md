# 🔗 RTL Asynchronous Dual-Clock FIFO (First-In First-Out) Design  
![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)
![Language: Verilog](https://img.shields.io/badge/language-Verilog-yellow.svg)
![Build: Simulated](https://img.shields.io/badge/build-simulated-green)
![Waveform: GTKWave](https://img.shields.io/badge/waveform-GTKwave-blue)
![CDC: Handled](https://img.shields.io/badge/CDC-Handled-red)

A synthesizable RTL design of an **Asynchronous (Dual-Clock) FIFO** implemented in Verilog. This FIFO allows safe and reliable data transfer between **two independent clock domains**—write and read—using pointer synchronization and Gray code logic. It's ideal for SoC designs, clock domain crossing (CDC), and multi-clock IP subsystems.

---

## 📌 Key Features

- Fully synthesizable RTL design
- Separate read and write clocks (`w_clk`, `r_clk`)
- Safe pointer synchronization using Gray codes
- Dual-port memory implementation
- `full` and `empty` flag generation
- Overflow and underflow protection (via flag logic)
- CDC (Clock Domain Crossing) safety via 2-stage flip-flop sync
- Includes waveform and RTL architecture visualization
- Testbench-driven simulation in GTKWave

---

## 🔧 RTL Design Block Diagram

The following diagram illustrates the internal architecture of the asynchronous FIFO:

- **Write Path**:  
  Data is written into FIFO memory when `wr_rq` is asserted and the FIFO is not full. A **Gray-coded write pointer** is updated and synchronized into the read clock domain for `empty` detection.

- **Read Path**:  
  Data is read from memory when `rd_rq` is asserted and the FIFO is not empty. A **Gray-coded read pointer** is updated and synchronized into the write clock domain for `full` detection.

- **Memory Block**:  
  A dual-port RAM is used to store the data, with concurrent read/write access controlled by the respective clock domains.

- **Synchronization Modules**:  
  Two flip-flop-based synchronizers (`sync_w2r`, `sync_r2w`) handle the safe transfer of Gray-coded pointers across clock domains.

<p align="center">
  <img src="https://github.com/SayantanMandal2000/rtl-fifo-designs/blob/main/asynchronous-dual-clock-fifo/images/Async_FIFO_RTL.png" alt="Async FIFO RTL Diagram" width="700"/>
</p>

---

## 💡 Theory

### ▶️ Why Asynchronous FIFO?

In modern SoC and FPGA designs, it is common to have components operating on **different clock domains**. Direct data transfer across these domains can lead to **metastability** and **data corruption**. An **asynchronous FIFO** serves as a reliable buffer that uses **Gray code pointer synchronization** and **handshake-free control** to ensure **data integrity and timing safety** between these domains.

---

### 🧠 Key Concepts:

- **Gray Code Pointers**:  
  Used to reduce metastability issues during cross-domain pointer transfer (only one bit changes at a time).

- **Double Synchronization**:  
  Each pointer crossing into the opposite clock domain passes through **two flip-flops**, which minimizes metastability and setup/hold violations.

- **Full and Empty Logic**:  
  - `full` is raised when the next write would overwrite unread data.
  - `empty` is raised when no data is available to read.

---

## 📈 Simulation Waveform

<p align="center">
  <img src="https://github.com/SayantanMandal2000/rtl-fifo-designs/blob/main/asynchronous-dual-clock-fifo/images/Async_FIFO_waveform.png" alt="FIFO Simulation Waveform" width="800"/>
</p>

The waveform shows:
- Write operations filling the FIFO until `full = 1`
- Read operations consuming the data correctly
- `empty = 1` once all data is read out

---

## 🧪 Testbench

The included testbench verifies:
- Proper reset behavior
- Full FIFO write and read cycles
- Flag transitions for `full` and `empty`
- Timing correctness between write and read domains

---

## 📁 File Structure

| File Name              | Description                                    |
|------------------------|------------------------------------------------|
| `async_fifo.v`         | Top-level asynchronous FIFO RTL module         |
| `fifo_mem.v`           | Dual-port RAM block for FIFO storage           |
| `sync_w2r.v`           | Synchronizes write pointer to read domain      |
| `sync_r2w.v`           | Synchronizes read pointer to write domain      |
| `full.v`               | Full flag generation logic (write domain)      |
| `empty.v`              | Empty flag generation logic (read domain)      |
| `tb_async_fifo.v`      | Testbench with clock gen and stimulus          |
| `Async_FIFO_RTL.png`   | RTL block diagram of the FIFO                  |
| `Async_FIFO_waveform.png` | Simulation waveform from GTKWave           |

