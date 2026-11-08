# 修复记录：CI 汇编跨平台符号前缀/链接失败（2026-11-08）

## 失败信息
- 仓库：wiseism/as_call_c
- Workflow：CMake on a ubuntu / CMake on a single platform macos
- 失败 run：[42429803722](https://github.com/wiseism/as_call_c/actions/runs/42429803722)（ubuntu）、[42429803726](https://github.com/wiseism/as_call_c/actions/runs/42429803726)（macos）

## 错误日志摘录
```
# ubuntu (x86_64 ELF)
main.c:(.text.startup+0x60): undefined reference to `my_strlen'
# macos (arm64 Mach-O)
Undefined symbols for architecture arm64:
  "_main", referenced from: ...
```

## 原因分析
1. 汇编源按 Mach-O 习惯给符号加 `_` 前缀（`_my_strlen`、`_main`、`_printf`），
   但 Linux ELF 符号不加前缀，导致 ubuntu 链接全部 undefined reference。
2. `asm_calls_c_arm64.s` 的入口叫 `_asm_calls_c_entry`，而可执行文件需要 `_main`，
   macos 链接失败。
3. ELF/PIE 下对 libc 动态符号的 `call` 需要 `wrt ..plt`，否则触发
   `relocation R_X86_64_PC32 ... can not be used when making a PIE object`。

## 修复内容
对 5 个 NASM 文件（`my_strlen.asm`、`asm_calls_c.asm`、`asm_stdlib.asm`、
`asm_math.asm`、`minimal_x86_64.asm`）按输出格式条件化生成符号：

- Mach-O：`global _xxx` / `extern _xxx` / `call _xxx` / 标签 `_xxx:`
- ELF：无前缀，且动态符号调用写成 `call xxx wrt ..plt`
- `asm_calls_c_arm64.s`：新增 `.global _main` 别名入口，`_asm_calls_c_entry` 保留
- `CMakeLists.txt` 无需改动（arm64 走 clang .s，x86 走 nasm）

## 本地验证（仅汇编/链接正确性确认，不替代 CI）
- `nasm -f elf64/-f macho64 -Werror` 全部 10 组汇编通过
- gcc+ld ELF 链接并运行 5 个目标（含 -lm）全部输出正确

## 验证
| run id | 结果 |
| --- | --- |
| 本次推送触发 | 待填 |
