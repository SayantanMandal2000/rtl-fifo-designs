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

  <p align="center">
  <img src="https://github.com/SayantanMandal2000/rtl-fifo-designs/blob/main/asynchronous-dual-clock-fifo/sim/Async_FIFO_Empty_RTL.png" alt="Async FIFO RTL Diagram" width="700"/>
</p>

- **Read Path**:  
  Data is read from memory when `rd_rq` is asserted and the FIFO is not empty. A **Gray-coded read pointer** is updated and synchronized into the write clock domain for `full` detection.

<p align="center">
  <img src="https://github.com/SayantanMandal2000/rtl-fifo-designs/blob/main/asynchronous-dual-clock-fifo/sim/Async_FIFO_Full_RTL.png" alt="Async FIFO RTL Diagram" width="700"/>
</p>

- **Memory Block**:  
  A dual-port RAM is used to store the data, with concurrent read/write access controlled by the respective clock domains.

<p align="center">
  <img src="https://github.com/SayantanMandal2000/rtl-fifo-designs/blob/main/asynchronous-dual-clock-fifo/sim/Async_FIFO_memRAM_RTL.png" alt="Async FIFO RTL Diagram" width="700"/>
</p>

- **Synchronization Modules**:  
  Two flip-flop-based synchronizers (`sync_w2r`, `sync_r2w`) handle the safe transfer of Gray-coded pointers across clock domains.
<p align="center">
  <img src="https://github.com/SayantanMandal2000/rtl-fifo-designs/blob/main/asynchronous-dual-clock-fifo/sim/Async_FIFO_syncw2r_RTL.png" alt="Async FIFO RTL Diagram" width="700"/>
</p>
<p align="center">
  <img src="https://github.com/SayantanMandal2000/rtl-fifo-designs/blob/main/asynchronous-dual-clock-fifo/sim/Async_FIFO_syncr2w_RTL.png" alt="Async FIFO RTL Diagram" width="700"/>
</p>

- **Asynchronous Dual-clock FIFO Top Module**: 
<p align="center">
  <img src="https://github.com/SayantanMandal2000/rtl-fifo-designs/blob/main/asynchronous-dual-clock-fifo/sim/Async_FIFO_RTL.png" alt="Async FIFO RTL Diagram" width="700"/>
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
  <img src="https://github.com/SayantanMandal2000/rtl-fifo-designs/blob/main/asynchronous-dual-clock-fifo/sim/Async_FIFO_waveform.png" alt="FIFO Simulation Waveform" width="800"/>
</p>

###✅ Observations:

-**Independent Clock Domains:**
'w_clk' (write clock) and r_clk (read clock) operate at different frequencies, demonstrating true asynchronous behavior.

-**Data Flow:**
Random hexadecimal data values (wdata) are written sequentially when 'wr_rq' is high and 'full' is low. The corresponding data is read out on the r_clk domain when 'rd_rq' is high and 'empty' is low.

-**Pointer Behavior:**
'wptr' (write pointer) increments on every successful write.
'rptr' (read pointer) increments on every successful read.
Both are implemented in Gray code internally for cross-domain synchronization.

-**FIFO Status Flags:**
'full' goes high temporarily when the FIFO is filled up faster than it is read.
'empty' clears only after valid data is read, and goes high again after the FIFO is fully drained.
At no point do we see undefined values in rdata, which confirms synchronization safety.

-**Memory Array:***
The 'fifo[7:0]' array reflects the internal dual-port memory buffer. Data written is visible here before being read out, showing proper retention and queue behavior.

---

###🧠 What This Proves:

The design correctly prevents overflow and underflow by asserting full and empty flags using synchronized pointers.
Gray code synchronization across clock domains ensures metastability-free operation.
The FIFO maintains data order, and pointer wraparound is handled without glitches.
The testbench verifies that writes and reads in independent domains do not interfere, even when clock ratios vary.

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

