# Windows PowerShell 效率工具集

[![PowerShell](https://img.shields.io/badge/PowerShell-5.1+-blue.svg)](https://github.com/PowerShell/PowerShell)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Stars](https://img.shields.io/github/stars/Pekmos/win-efficiency-tools?style=social)](https://github.com/Pekmos/win-efficiency-tools/stargazers)

> 一键解决 Windows 日常使用痛点，提升 10 倍效率

[中文](#中文) | [English](#english)

---

## 中文

### 🚀 快速开始

```powershell
# 克隆仓库
git clone https://github.com/Pekmos/win-efficiency-tools.git

# 进入目录
cd win-efficiency-tools

# 运行工具（以管理员身份运行 PowerShell）
.\tools\organize-files.ps1
```

### 📦 包含工具

| 工具 | 功能 | 节省时间 |
|------|------|---------|
| [organize-files.ps1](tools/organize-files.ps1) | 自动整理桌面/下载文件夹 | 30分钟/次 |
| [process-images.ps1](tools/process-images.ps1) | 批量压缩、改尺寸、加水印 | 1小时/次 |

### ✨ 功能特点

- **零配置**：下载即用，无需安装
- **安全**：本地运行，不上传任何数据
- **开源**：代码透明，可自由修改
- **持续更新**：定期添加新工具

### 📖 使用示例

#### 整理桌面文件
```powershell
# 整理桌面（默认）
.\tools\organize-files.ps1

# 整理下载文件夹
.\tools\organize-files.ps1 -SourcePath "$env:USERPROFILE\Downloads"
```

#### 批量处理图片
```powershell
# 压缩图片到 800px 宽度，质量 80%
.\tools\process-images.ps1 -MaxWidth 800 -Quality 80

# 添加水印
.\tools\process-images.ps1 -WatermarkText "© 2024"
```

### 🤝 贡献

欢迎提交 Issue 和 PR！

### ☕ 支持

如果这个工具帮到了你，可以考虑请作者喝杯咖啡：

[![GitHub Sponsors](https://img.shields.io/github/sponsors/Pekmos?style=social)](https://github.com/sponsors/Pekmos)

---

## English

### 🚀 Quick Start

```powershell
# Clone the repository
git clone https://github.com/Pekmos/win-efficiency-tools.git

# Enter directory
cd win-efficiency-tools

# Run tools (run PowerShell as Administrator)
.\tools\organize-files.ps1
```

### 📦 Included Tools

| Tool | Function | Time Saved |
|------|----------|------------|
| [organize-files.ps1](tools/organize-files.ps1) | Auto-organize Desktop/Downloads | 30min/run |
| [process-images.ps1](tools/process-images.ps1) | Batch compress, resize, watermark | 1hr/run |

### ✨ Features

- **Zero Config**: Download and use, no installation
- **Secure**: Runs locally, no data upload
- **Open Source**: Transparent code, free to modify
- **Regular Updates**: New tools added periodically

### ☕ Support

If this tool helps you, consider buying me a coffee:

[![GitHub Sponsors](https://img.shields.io/github/sponsors/Pekmos?style=social)](https://github.com/sponsors/Pekmos)

---

## License

MIT License - see [LICENSE](LICENSE) file
