# ARM64 Simulation on Intel Mac

This guide explains how to run ARM64 assembly code on an Intel Mac (x86_64).

## Methods

### 1. QEMU User Mode Emulation (Recommended)

QEMU can run ARM64 binaries on x86_64 systems with good performance.

#### Installation

```bash
brew install qemu
```

#### Building for ARM64

```bash
# Clean previous build
rm -rf build_arm64
mkdir build_arm64
cd build_arm64

# Configure for ARM64 (cross-compilation)
cmake .. -DCMAKE_SYSTEM_NAME=Darwin \
         -DCMAKE_SYSTEM_PROCESSOR=aarch64 \
         -DCMAKE_C_COMPILER=clang \
         -DCMAKE_C_COMPILER_TARGET=aarch64-apple-darwin \
         -DCMAKE_ASM_COMPILER=clang \
         -DCMAKE_ASM_COMPILER_TARGET=aarch64-apple-darwin

# Build
make
```

#### Running ARM64 Binaries

```bash
# Run ARM64 executable with QEMU
qemu-aarch64 ./minimal_example
```

### 2. Docker with ARM64 Image

Use Docker to run ARM64 containers.

#### Installation

```bash
brew install --cask docker
```

#### Running in Docker

```bash
# Build for ARM64 (requires cross-compilation setup)
docker run --rm -v $(pwd):/workspace -w /workspace \
    arm64v8/ubuntu:latest \
    bash -c "apt-get update && apt-get install -y build-essential cmake && \
    mkdir build && cd build && \
    cmake .. && make && \
    ./minimal_example"
```

### 3. GitHub Actions (Easiest)

Push your code to GitHub and let GitHub Actions run on ARM64 runners.

#### Using GitHub Actions

1. Push your code to GitHub
2. GitHub Actions will automatically run on both x86_64 and ARM64 runners
3. Check the Actions tab to see ARM64 test results

## Cross-Compilation Setup

### Installing ARM64 Toolchain

```bash
# Install ARM64 compiler (if needed)
brew install aarch64-elf-gcc
```

### CMake Configuration for ARM64

```cmake
if(CMAKE_SYSTEM_PROCESSOR MATCHES "aarch64|arm64")
    # ARM64 specific settings
    set(IS_ARM64 TRUE)
else()
    # x86_64 specific settings
    set(IS_ARM64 FALSE)
endif()
```

## Testing ARM64 Code Locally

### Quick Test with QEMU

```bash
# 1. Build for ARM64
mkdir -p build_arm64
cd build_arm64
cmake .. -DCMAKE_SYSTEM_PROCESSOR=aarch64
make

# 2. Run with QEMU
qemu-aarch64 ./minimal_example
```

### Expected Output

```
Sum: 60
Product: 200
```

## Limitations

- **Performance**: QEMU emulation is slower than native execution
- **Compatibility**: Some macOS-specific features may not work in emulation
- **Debugging**: Debugging emulated code can be more complex

## Recommended Approach

For development on Intel Mac:

1. **Primary**: Develop and test on x86_64 (native)
2. **Verification**: Use QEMU to verify ARM64 builds
3. **CI/CD**: Use GitHub Actions for comprehensive ARM64 testing

## Additional Resources

- [QEMU Documentation](https://www.qemu.org/docs/master/)
- [ARM64 Assembly Guide](https://developer.arm.com/documentation/)
- [Cross-Compilation with CMake](https://cmake.org/cmake/help/latest/manual/cmake-toolchains.7.html)
