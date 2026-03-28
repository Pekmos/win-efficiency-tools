# 文件自动整理工具
# 功能：按文件类型自动分类整理桌面/下载文件夹

param(
    [string]$SourcePath = "$env:USERPROFILE\Desktop",
    [string]$TargetPath = "$env:USERPROFILE\Documents\AutoOrganized"
)

# 创建分类文件夹
$Categories = @{
    "Images" = @(".jpg", ".jpeg", ".png", ".gif", ".bmp", ".webp", ".svg")
    "Documents" = @(".pdf", ".doc", ".docx", ".txt", ".rtf", ".xls", ".xlsx", ".ppt", ".pptx")
    "Videos" = @(".mp4", ".avi", ".mkv", ".mov", ".wmv", ".flv", ".webm")
    "Audio" = @(".mp3", ".wav", ".flac", ".aac", ".ogg", ".wma")
    "Archives" = @(".zip", ".rar", ".7z", ".tar", ".gz")
    "Code" = @(".py", ".js", ".html", ".css", ".java", ".cpp", ".c", ".h", ".php", ".json", ".xml")
    "Executables" = @(".exe", ".msi", ".bat", ".cmd", ".ps1")
}

# 创建目标文件夹
if (!(Test-Path $TargetPath)) {
    New-Item -ItemType Directory -Path $TargetPath | Out-Null
    Write-Host "✓ 创建目标文件夹: $TargetPath" -ForegroundColor Green
}

foreach ($Category in $Categories.Keys) {
    $CategoryPath = Join-Path $TargetPath $Category
    if (!(Test-Path $CategoryPath)) {
        New-Item -ItemType Directory -Path $CategoryPath | Out-Null
    }
}

# 获取文件（排除快捷方式和文件夹）
$Files = Get-ChildItem -Path $SourcePath -File | Where-Object { 
    $_.Extension -notin @('.lnk', '.url') 
}

Write-Host "`n找到 $($Files.Count) 个文件待整理...`n" -ForegroundColor Cyan

$MovedCount = 0
$SkippedCount = 0

foreach ($File in $Files) {
    $Extension = $File.Extension.ToLower()
    $CategoryFound = $false
    
    foreach ($Category in $Categories.Keys) {
        if ($Extension -in $Categories[$Category]) {
            $TargetFile = Join-Path (Join-Path $TargetPath $Category) $File.Name
            
            # 处理重名文件
            $Counter = 1
            $BaseName = [System.IO.Path]::GetFileNameWithoutExtension($File.Name)
            while (Test-Path $TargetFile) {
                $NewName = "$BaseName`_$Counter$Extension"
                $TargetFile = Join-Path (Join-Path $TargetPath $Category) $NewName
                $Counter++
            }
            
            try {
                Move-Item -Path $File.FullName -Destination $TargetFile -Force
                Write-Host "✓ [$Category] $($File.Name)" -ForegroundColor Green
                $MovedCount++
                $CategoryFound = $true
                break
            }
            catch {
                Write-Host "✗ 失败: $($File.Name) - $($_.Exception.Message)" -ForegroundColor Red
                $SkippedCount++
            }
        }
    }
    
    # 未分类文件放入 Others
    if (!$CategoryFound) {
        $OthersPath = Join-Path $TargetPath "Others"
        if (!(Test-Path $OthersPath)) {
            New-Item -ItemType Directory -Path $OthersPath | Out-Null
        }
        $TargetFile = Join-Path $OthersPath $File.Name
        Move-Item -Path $File.FullName -Destination $TargetFile -Force
        Write-Host "✓ [Others] $($File.Name)" -ForegroundColor Yellow
        $MovedCount++
    }
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "整理完成!" -ForegroundColor Green
Write-Host "移动文件: $MovedCount" -ForegroundColor Green
Write-Host "跳过/失败: $SkippedCount" -ForegroundColor $(if($SkippedCount -gt 0){"Red"}else{"Green"})
Write-Host "目标位置: $TargetPath" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# 打开目标文件夹
Start-Process explorer.exe $TargetPath
