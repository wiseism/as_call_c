# Architecture Support

This project supports both x86_64 and ARM64 (Apple Silicon) architectures with native assembly implementations.

## x86_64 (Intel/AMD)

- Uses NASM assembly for optimized implementations
- All four executables are available:
  - `asm_call_c` - C calling assembly functions
  - `asm_calls_c` - Assembly calling custom C functions
  - `asm_stdlib` - Assembly calling C standard library
  - `asm_math` - Assembly calling C math library

## ARM64 (Apple Silicon)

- Uses ARM64 assembly (GAS syntax) for optimized implementations
- All four executables are available:
  - `asm_call_c` - C calling assembly functions
  - `asm_calls_c` - Assembly calling custom C functions
  - `asm_stdlib` - Assembly calling C standard library
  - `asm_math` - Assembly calling C math library

## CMake Configuration

The CMakeLists.txt automatically detects the architecture:

```cmake
if(CMAKE_SYSTEM_PROCESSOR MATCHES "aarch64|arm64")
    message(STATUS "Building for ARM64 architecture - using ARM64 assembly")
    set(IS_ARM64 TRUE)
else()
    message(STATUS "Building for x86_64 architecture - using NASM assembly")
    enable_language(ASM_NASM)
    set(IS_ARM64 FALSE)
endif()
```

## GitHub Actions

For GitHub Actions, the build will automatically select the appropriate implementation based on the runner architecture:

- **macOS-latest (x86_64)**: Uses NASM assembly
- **macOS-latest (ARM64)**: Uses ARM64 assembly

No additional configuration needed - the CMake script handles architecture detection automatically.

## Assembly Differences

### x86_64 (NASM)
- Syntax: Intel syntax
- File extension: `.asm`
- Registers: `rax`, `rbx`, `rcx`, etc.
- Calling convention: System V AMD64 ABI

### ARM64 (GAS)
- Syntax: AT&T/GAS syntax
- File extension: `.s`
- Registers: `x0`-`x30`, `w0`-`w30`, `d0`-`d31`
- Calling convention: AAPCS64

Both architectures provide native assembly implementations for maximum performance.
