cmake_minimum_required(VERSION 3.10)
project(asm_call_c C ASM)

set(CMAKE_C_STANDARD 11)

if(CMAKE_SYSTEM_PROCESSOR MATCHES "aarch64|arm64")
    message(STATUS "Building for ARM64 architecture - using ARM64 assembly")
    set(IS_ARM64 TRUE)
else()
    message(STATUS "Building for x86_64 architecture - using NASM assembly")
    enable_language(ASM_NASM)
    set(IS_ARM64 FALSE)
endif()

if(APPLE AND NOT IS_ARM64)
    set(CMAKE_ASM_NASM_OBJECT_FORMAT macho64)
endif()

if(IS_ARM64)
    set(ASM_CALL_C_SOURCES
        my_strlen_arm64.s
    )
else()
    set(ASM_CALL_C_SOURCES
        my_strlen.asm
    )
endif()

set(C_SOURCES
    main.c
)

add_executable(asm_call_c ${ASM_CALL_C_SOURCES} ${C_SOURCES})

if(APPLE)
    target_link_options(asm_call_c PRIVATE -Wl,-no_pie)
endif()

if(IS_ARM64)
    set(ASM_CALLS_C_ASM
        asm_calls_c_arm64.s
    )

    set(ASM_CALLS_C_SOURCES
        c_functions.c
    )

    add_executable(asm_calls_c ${ASM_CALLS_C_ASM} ${ASM_CALLS_C_SOURCES})

    if(APPLE)
        target_link_options(asm_calls_c PRIVATE -Wl,-no_pie)
    endif()
else()
    set(ASM_CALLS_C_ASM
        asm_calls_c.asm
    )

    set(ASM_CALLS_C_SOURCES
        c_functions.c
    )

    add_executable(asm_calls_c ${ASM_CALLS_C_ASM} ${ASM_CALLS_C_SOURCES})

    if(APPLE)
        target_link_options(asm_calls_c PRIVATE -Wl,-no_pie)
    endif()
endif()

if(IS_ARM64)
    set(ASM_STDLIB_ASM
        asm_stdlib_arm64.s
    )

    set(ASM_STDLIB_C
        asm_stdlib_wrapper.c
    )

    add_executable(asm_stdlib ${ASM_STDLIB_ASM} ${ASM_STDLIB_C})

    if(APPLE)
        target_link_options(asm_stdlib PRIVATE -Wl,-no_pie)
    endif()
else()
    set(ASM_STDLIB_ASM
        asm_stdlib.asm
    )

    set(ASM_STDLIB_C
        asm_stdlib_wrapper.c
    )

    add_executable(asm_stdlib ${ASM_STDLIB_ASM} ${ASM_STDLIB_C})

    if(APPLE)
        target_link_options(asm_stdlib PRIVATE -Wl,-no_pie)
    endif()
endif()

if(IS_ARM64)
    set(ASM_MATH_ASM
        asm_math_arm64.s
    )

    set(ASM_MATH_C
        asm_math_wrapper.c
    )

    add_executable(asm_math ${ASM_MATH_ASM} ${ASM_MATH_C})

    if(APPLE)
        target_link_options(asm_math PRIVATE -Wl,-no_pie)
    endif()

    target_link_libraries(asm_math m)
else()
    set(ASM_MATH_ASM
        asm_math.asm
    )

    set(ASM_MATH_C
        asm_math_wrapper.c
    )

    add_executable(asm_math ${ASM_MATH_ASM} ${ASM_MATH_C})

    if(APPLE)
        target_link_options(asm_math PRIVATE -Wl,-no_pie)
    endif()

    target_link_libraries(asm_math m)
endif()
