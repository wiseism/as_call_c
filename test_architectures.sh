#!/bin/bash

echo "=========================================="
echo "ARM64 Testing on Intel Mac"
echo "=========================================="
echo ""

echo "1. Testing x86_64 (Native)..."
if [ -f "build/minimal_example" ]; then
    echo "Running x86_64 version:"
    ./build/minimal_example
    echo ""
else
    echo "x86_64 version not found. Run 'mkdir build && cd build && cmake .. && make' first."
    echo ""
fi

echo "2. Checking QEMU installation..."
if command -v qemu-aarch64 &> /dev/null; then
    echo "✓ QEMU is installed"
    echo ""
    
    if [ -f "build_arm64/minimal_example" ]; then
        echo "3. Running ARM64 version with QEMU..."
        echo "Running: qemu-aarch64 build_arm64/minimal_example"
        qemu-aarch64 build_arm64/minimal_example
    else
        echo "✗ ARM64 build not found"
        echo ""
        echo "To build for ARM64, run:"
        echo "  ./run_arm64.sh build"
        echo ""
        echo "Then run with:"
        echo "  ./run_arm64.sh run"
    fi
else
    echo "✗ QEMU not installed"
    echo ""
    echo "To install QEMU:"
    echo "  brew install qemu"
    echo ""
    echo "Alternative: Use GitHub Actions for ARM64 testing"
fi

echo ""
echo "=========================================="
echo "Summary:"
echo "- x86_64: Native (fast, available now)"
echo "- ARM64: Requires QEMU or GitHub Actions"
echo "=========================================="
