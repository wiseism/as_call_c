# 修复 multi-arch：macos-14 + arm64 组合不被支持

## 失败信息
- Run 42442834168（Build and Test Multi-Architecture）：
  `The configuration 'macos-14-arm64-us-default' is not supported`（job 1 秒即失败）
  x86_64 job 正常 ✅。

## 原因分析
- runner 标签 `macos-14` + `arch: arm64` 的组合已不被支持
  （macos-14 镜像已退役，arm64 由 macos-14/macos-latest 演进；当前 macos-latest 即 arm64）。

## 修复内容
- matrix 中 `os: macos-14, arch: arm64` → `os: macos-latest, arch: arm64`。

## 验证记录
| Run | 结果 |
|---|---|
| 42442834168 (x86_64 job) | ✅ success |
| 43224726121 (daad903) | ✅ success |
