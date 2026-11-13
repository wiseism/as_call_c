# 修复记录：macos arm64 变参调用 ABI 导致运行时崩溃（2026-11-08）

## 失败信息
- 仓库：wiseism/as_call_c
- Workflow：CMake on a single platform macos
- 失败 run：[42441411433](https://github.com/wiseism/as_call_c/actions/runs/42441411433)（2026-11-08，ubuntu 对应 run 42441411358 已 ✅ success）

## 错误日志摘录
```
Testing asm_stdlib...
=== Assembly calling C Standard Library ===
Abort trap: 6   ./asm_stdlib
##[error]Process completed with exit code 134.
```
（前一次日志还伴随 printf%s 的参数垃圾值: `number=1835704032` 等）

## 原因分析
Apple silicon (arm64 macOS) 的变参调用约定与 Linux/标准 AAPCS64 不同：
**从第 2 个参数起的所有变参实参必须压栈**（寄存器 x1..x7 只用于非变参）
— 参见 Apple 官方文档《Writing ARM64 code for Apple platforms》及 clang 生成代码。
原 asm 文件按 Linux 寄存器传参（`mov x1,#42; mov x2,#100; bl _printf`），
macOS 上 printf 读到垃圾/崩溃。

另有两个隐藏 bug 一并修复：
1. `asm_stdlib_arm64.s` 将 malloc 指针存在 `[x29,#-8]`（位于 sp 之下，属于
   下一层调用的栈区），printf 调用把它冲成垃圾随后 `free(垃圾指针)` → abort。
   改存帧内保留区 `[x29,#16]`。
2. `asm_math_arm64.s` 尾部重复两次 `ldp x29, x30, [sp], #32`，栈错乱。

## 修复内容
已确认 arm64 .s 仅在 macOS arm64 构建使用： Apple 约定改写）
- `asm_stdlib_arm64.s`：5 处 printf  `sub sp,sp,#16` + `str/slot` 压栈，
  调用后 `add sp,sp,#16` 清退；malloc 指针保存位置修正。
- `asm_math_arm64.s`：11 处 `%f` printf —— `str d0, [sp]`（double 变参入栈）；
  删除重复 ldp。
- `minimal_arm64.s`：2 处 `%d` printf —— int 变参 `str x10, [sp]`。
- 非变参调用（puts/strlen/strcpy/strcmp/malloc/free/sin…）保持寄存器传参不变。

## 验证
| run id | 结果 |
| --- | --- |
| 43225033908 (multi-arch) / 43225033520 (ubuntu) | ✅ success |

### 第2次复测(42442330769)
- math 全部输出正确; minimal_example segfault: 保存 x21 用了 [sp,#8] 且帧仅 32B, 覆盖了 x29 保存槽。帧改 48B 并改槽位 [sp,#16/24/32], 退出前 ldr 恢复。
