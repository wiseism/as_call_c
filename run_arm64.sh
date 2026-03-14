#!/bin/bash

set -e

echo "ARM64 Assembly Runner for Intel Mac"
echo "===================================="
echo ""

BUILD_DIR="build_arm64"
EXECUTABLE="minimal_example"

if [ "$1" = "clean" ]; then
    echo "Cleaning build directory..."
    rm -rf ${BUILD_DIR}
    exit 0
fi

if [ "$1" = "build" ]; then
    echo "Building for ARM64..."
    mkdir -p ${BUILD_DIR}
    cd ${BUILD_DIR}
    cmake .. -DCMAKE_SYSTEM_PROCESSOR=aarch64
    make
    cd ..
    exit 0
fi

if [ "$1" = "run" ]; then
    if [ ! -f "${BUILD_DIR}/${EXECUTABLE}" ]; then
        echo "Error: ${EXECUTABLE} not found. Run '$0 build' first."
        exit 1
    fi
    echo "Running ARM64 executable with QEMU..."
    qemu-aarch64 ${BUILD_DIR}/${EXECUTABLE}
    exit 0
fi

if [ "$1" = "all" ]; then
    $0 clean
    $0 build
    $0 run
    exit 0
fi

echo "Usage: $0 [command]"
echo ""
echo "Commands:"
echo "  clean  - Clean build directory"
echo "  build  - Build for ARM64"
echo "  run    - Run ARM64 executable with QEMU"
echo "  all    - Clean, build, and run"
echo ""
echo "Examples:"
echo "  $0 all"
echo "  $0 build"
echo "  $0 run"
