# direct_mapped_cache
# Direct-Mapped Cache Memory (Verilog Implementation)

## Overview

This repository contains a Verilog implementation of a **Direct-Mapped Cache Memory**. The design follows a **direct-mapped** approach where each memory address is mapped to a specific cache line based on an indexing function.

## Features

- **Configurable Parameters**:
  - `DATA_WIDTH`: Defines the width of data (default: 32 bits)
  - `ADDR_WIDTH`: Defines the width of memory addresses (default: 8 bits)
  - `CACHE_SIZE`: Specifies the number of cache lines (default: 16 lines)
- **Read and Write Operations**
- **Tag Matching for Cache Hits**
- **Valid Bit Management**
- **Simple Reset Mechanism**

## Cache Design

The cache structure includes:

- **Cache Data Array**: Stores the actual data.
- **Tag Array**: Stores the tag bits corresponding to each cache line.
- **Valid Bit Array**: Keeps track of valid cache lines.

## Address Breakdown

Each address is divided into:

- **Index**: Determines the cache line (Lower half of address bits).
- **Tag**: Used for comparison to check for cache hits (Upper half of address bits).

## Module Interface

### Inputs

| Signal      | Width        | Description         |
| ----------- | ------------ | ------------------- |
| `clk`       | 1-bit        | System clock        |
| `rst`       | 1-bit        | Reset signal        |
| `addr`      | `ADDR_WIDTH` | Memory address      |
| `wr_data`   | `DATA_WIDTH` | Data to be written  |
| `mem_write` | 1-bit        | Memory write enable |
| `mem_read`  | 1-bit        | Memory read enable  |

### Outputs

| Signal      | Width        | Description                       |
| ----------- | ------------ | --------------------------------- |
| `read_data` | `DATA_WIDTH` | Data read from cache              |
| `hit`       | 1-bit        | Indicates if a cache hit occurred |

## Operation

1. **Reset (`rst` active)**:
   - Initializes the valid array to `0`, marking all cache lines as invalid.
2. **Memory Read (`mem_read` active)**:
   - Checks if the tag matches and the valid bit is set.
   - If a match is found, a **cache hit** occurs, and data is read from the cache.
   - If there is no match, a **cache miss** occurs, and the system should ideally fetch data from main memory (not implemented here).
3. **Memory Write (`mem_write` active)**:
   - Stores new data into the cache at the indexed location.
   - Updates the corresponding tag and marks the entry as valid.


```

## Files

| File                           | Description                                   |
| ------------------------------ | --------------------------------------------- |
| `direct_mapped_cache_memory.v` | Verilog implementation of direct-mapped cache |
| `testbench.v`                  | Testbench for cache simulation                |
| `README.md`                    | Project documentation                         |

## Simulation & Testing

1. Load `direct_mapped_cache_memory.v` and `testbench.v` in a Verilog simulator.
2. Run the simulation and check for cache hits/misses.
3. Observe how data is written and retrieved from the cache.

## Future Enhancements

- Implement main memory interaction for cache misses.
- Add write-back and write-through policies.
- Introduce associativity (e.g., 2-way or 4-way set-associative cache).

## Contributors

- **Your Name** - Initial Implementation

## License

This project is open-source and licensed under the MIT License.

