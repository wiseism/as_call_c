# Minimal Assembly Example

This directory contains minimal runnable assembly examples for macOS demonstrating proper stack alignment and register usage.

## Files

- **minimal_x86_64.asm** - x86_64 (Intel/AMD) assembly example
- **minimal_arm64.s** - ARM64 (Apple Silicon) assembly example
- **minimal_wrapper.c** - C wrapper to provide program entry point

## Features Demonstrated

### x86_64 (NASM)
- Stack alignment using `sub rsp, 32` (16-byte alignment)
- Local variable storage on stack: `[rbp-8]`, `[rbp-16]`, `[rbp-24]`
- Register usage: `rax`, `rbp`, `rsp`, `rdi`, `rsi`
- Function calls with proper calling convention
- External function declaration: `extern _printf`

### ARM64 (GAS)
- Stack alignment using `stp x29, x30, [sp, #-32]!` (16-byte alignment)
- Local variable storage on stack: `[sp, #24]`, `[sp, #16]`, `[sp, #8]`
- Register usage: `x0`, `x1`, `x2`, `x29`, `x30`, `x19`, `x20`, `x21`
- Callee-saved registers: `x19`, `x20`, `x21`
- Function calls with proper AAPCS64 calling convention
- External function declaration: `.extern _printf`

## Building

```bash
mkdir build && cd build
cmake ..
make
```

## Running

```bash
./build/minimal_example
```

## Expected Output

```
Sum: 60
Product: 200
```

## Technical Details

### Stack Alignment
Both examples maintain 16-byte stack alignment as required by macOS calling conventions:
- **x86_64**: `sub rsp, 32` allocates 32 bytes (16-byte aligned)
- **ARM64**: `stp x29, x30, [sp, #-32]!` allocates 32 bytes (16-byte aligned)

### Register Usage
- **x86_64**: Uses general-purpose registers and System V AMD64 ABI
- **ARM64**: Uses general-purpose registers and AAPCS64 calling convention

### Local Variables
Both examples store local variables on the stack frame:
- **x86_64**: Uses negative offsets from RBP
- **ARM64**: Uses positive offsets from SP

## Cross-Platform Support

The CMake build system automatically selects the appropriate assembly file based on the target architecture:
- **x86_64**: Uses `minimal_x86_64.asm`
- **ARM64**: Uses `minimal_arm64.s`
