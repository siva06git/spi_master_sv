<img width="1425" height="1023" alt="cmos_vlsi excalidraw" src="https://github.com/user-attachments/assets/2f8a422b-b24e-480c-844d-4a52a2dc220a" />
## Architecture Overview

The SPI Master is implemented as a collection of modular RTL blocks, each responsible for a specific function within the data path and control path.

- **SPI Registers** store configuration parameters such as CPOL, CPHA, clock divider, chip select, transfer size, and control/status bits. These registers are programmed by the CPU through a 32-bit interface.
- **FSM (Finite State Machine)** coordinates the entire SPI transaction by controlling FIFO accesses, PISO/SIPO operations, clock generation, and transfer completion.
- **Clock Divider** generates the SPI serial clock (SCLK) from the system clock according to the programmed divider value.
- **TX FIFO** buffers outgoing data from the CPU before it is loaded into the PISO register for serial transmission over MOSI.
- **PISO Register** converts 8-bit parallel data into a serial bit stream synchronized with SCLK.
- **SIPO Register** samples incoming serial data from MISO and converts it into 8-bit parallel data.
- **RX FIFO** stores received bytes until they are read by the CPU.
- **Interrupt Controller** monitors FIFO and transfer status, generating interrupt requests when enabled by the CPU.

The architecture separates the **control path** (FSM and configuration registers) from the **data path** (FIFOs, shift registers, and clock divider), making the design modular, reusable, and easy to extend. All modules communicate through well-defined interfaces, allowing independent development, verification, and future enhancements.

> **Note:** This architecture was designed specifically for this project. While the implementation follows the standard SPI protocol, the RTL partitioning, module interactions, and control flow are my own design.
