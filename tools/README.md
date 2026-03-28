# 自动化工具套件 - 使用说明

## 📦 已安装工具

### 1. 文件自动整理工具 (organize-files.ps1)
**功能**：自动按类型整理桌面/文件夹

**使用方法**：
```powershell
# 整理桌面
.\organize-files.ps1

# 整理下载文件夹
.\organize-files.ps1 -SourcePath "$env:USERPROFILE\Downloads"

# 自定义目标位置
.\organize-files.ps1 -SourcePath "C:\MyFiles" -TargetPath "D:\Organized"
```

**自动分类**：
- Images（图片）
- Documents（文档）
- Videos（视频）
- Audio（音频）
- Archives（压缩包）
- Code（代码文件）
- Executables（可执行文件）
- Others（其他）

---

### 2. 图片批量处理工具 (process-images.ps1)
**功能**：批量压缩、改尺寸、加水印

**使用方法**：
```powershell
# 基础用法（处理图片文件夹）
.\process-images.ps1

# 自定义参数
.\process-images.ps1 `
    -InputFolder "C:\MyPhotos" `
    -OutputFolder "C:\MyPhotos\Web" `
    -MaxWidth 800 `
    -Quality 80 `
    -WatermarkText "© 2024"

# 包含子文件夹
.\process-images.ps1 -Recursive
```

**参数说明**：
- `MaxWidth`：最大宽度（默认1200px）
- `Quality`：JPEG质量 1-100（默认85）
- `WatermarkText`：水印文字
- `Recursive`：是否处理子文件夹

---

## 🚀 快速开始

### 第一步：打开 PowerShell
按 `Win + X`，选择 "Windows PowerShell" 或 "终端"

### 第二步：进入工具目录
```powershell
cd C:\Users\1\.openclaw\workspace\tools
```

### 第三步：运行工具
```powershell
# 整理桌面文件
.\organize-files.ps1

# 处理图片
.\process-images.ps1
```

---

## 💡 使用场景

| 场景 | 使用工具 | 节省时间 |
|------|---------|---------|
| 桌面太乱 | organize-files.ps1 | 30分钟 |
| 照片太大传不了微信 | process-images.ps1 | 1小时 |
| 整理下载文件夹 | organize-files.ps1 | 20分钟 |
| 批量改图片尺寸 | process-images.ps1 | 2小时 |

---

## 📊 价值统计

每次使用节省的时间：
- 文件整理：30分钟 × 时薪 = 约50元价值
- 图片处理：1小时 × 时薪 = 约100元价值

**使用10次 = 节省500-1000元时间成本**

---

## 🔧 后续计划

更多自动化工具开发中：
- [ ] 自动备份工具
- [ ] 重复文件清理
- [ ] 批量重命名（高级版）
- [ ] 定时任务管理器

---

*这些工具完全免费，持续更新*
