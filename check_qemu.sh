#!/bin/bash

echo "=========================================="
echo "QEMU Installation Status"
echo "=========================================="
echo ""

echo "Checking QEMU installation..."
if command -v qemu-aarch64 &> /dev/null; then
    echo "✓ qemu-aarch64 (user mode) is installed"
    QEMU_USER="qemu-aarch64"
elif command -v qemu-aarch64-static &> /dev/null; then
    echo "✓ qemu-aarch64-static is installed"
    QEMU_USER="qemu-aarch64-static"
elif command -v qemu-system-aarch64 &> /dev/null; then
    echo "✓ qemu-system-aarch64 (system mode) is installed"
    QEMU_SYS="qemu-system-aarch64"
    echo "  Note: System mode requires full OS, not suitable for simple executables"
else
    echo "✗ QEMU not found"
    echo ""
    echo "To install QEMU user mode:"
    echo "  brew install qemu"
    echo ""
    echo "Current QEMU binaries:"
    ls /usr/local/bin/qemu* 2>/dev/null | head -10
    exit 1
fi

echo ""
echo "=========================================="
echo "Recommendation:"
echo "=========================================="
echo ""
echo "For ARM64 testing on Intel Mac, you have several options:"
echo ""
echo "1. GitHub Actions (Recommended):"
echo "   - Push code to GitHub"
echo "   - Automatic ARM64 testing on real hardware"
echo "   - No local setup required"
echo ""
echo "2. Docker with QEMU:"
echo "   - brew install docker"
echo "   - docker build -f Dockerfile.arm64 ."
echo "   - docker run --rm asm-arm64"
echo ""
echo "3. Cross-compile for ARM64:"
echo "   - Build ARM64 binaries locally"
echo "   - Test on ARM64 device or GitHub Actions"
echo ""
echo "4. Wait for QEMU user mode installation:"
echo "   - Complete current brew install qemu"
echo "   - Use qemu-aarch64 for testing"
echo ""
echo "=========================================="
