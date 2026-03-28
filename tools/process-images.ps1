# 图片批量处理工具
# 功能：批量压缩、改尺寸、加水印

param(
    [string]$InputFolder = "$env:USERPROFILE\Pictures",
    [string]$OutputFolder = "$env:USERPROFILE\Pictures\Processed",
    [int]$MaxWidth = 1200,
    [int]$Quality = 85,
    [string]$WatermarkText = "",
    [switch]$Recursive
)

# 检查是否有图片处理依赖
function Test-ImageMagick {
    $magick = Get-Command magick -ErrorAction SilentlyContinue
    return $magick -ne $null
}

function Test-DotNet {
    try {
        Add-Type -AssemblyName System.Drawing -ErrorAction Stop
        return $true
    }
    catch {
        return $false
    }
}

Write-Host "`n🖼️  图片批量处理工具`n" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# 创建输出文件夹
if (!(Test-Path $OutputFolder)) {
    New-Item -ItemType Directory -Path $OutputFolder | Out-Null
    Write-Host "✓ 创建输出文件夹: $OutputFolder" -ForegroundColor Green
}

# 获取图片文件
$ImageExtensions = @("*.jpg", "*.jpeg", "*.png", "*.bmp", "*.gif")
$SearchOption = if ($Recursive) { [System.IO.SearchOption]::AllDirectories } else { [System.IO.SearchOption]::TopDirectoryOnly }

$Images = @()
foreach ($ext in $ImageExtensions) {
    $Images += Get-ChildItem -Path $InputFolder -Filter $ext -Recurse:$Recursive
}

if ($Images.Count -eq 0) {
    Write-Host "⚠️  未找到图片文件" -ForegroundColor Yellow
    exit
}

Write-Host "找到 $($Images.Count) 张图片待处理`n" -ForegroundColor Cyan

# 使用 .NET 处理图片
if (Test-DotNet) {
    Add-Type -AssemblyName System.Drawing
    
    $Processed = 0
    $Failed = 0
    
    foreach ($Image in $Images) {
        try {
            $OutputPath = Join-Path $OutputFolder $Image.Name
            
            # 加载图片
            $img = [System.Drawing.Image]::FromFile($Image.FullName)
            
            # 计算新尺寸
            $NewWidth = $img.Width
            $NewHeight = $img.Height
            
            if ($img.Width -gt $MaxWidth) {
                $Ratio = $MaxWidth / $img.Width
                $NewWidth = $MaxWidth
                $NewHeight = [int]($img.Height * $Ratio)
            }
            
            # 创建新图片
            $NewImg = New-Object System.Drawing.Bitmap($NewWidth, $NewHeight)
            $Graphics = [System.Drawing.Graphics]::FromImage($NewImg)
            $Graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
            $Graphics.DrawImage($img, 0, 0, $NewWidth, $NewHeight)
            
            # 添加水印（如果指定）
            if ($WatermarkText -ne "") {
                $Font = New-Object System.Drawing.Font("Arial", 20)
                $Brush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(128, 255, 255, 255))
                $Graphics.DrawString($WatermarkText, $Font, $Brush, 10, $NewHeight - 40)
                $Font.Dispose()
                $Brush.Dispose()
            }
            
            # 保存
            $Encoder = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.FormatDescription -eq "JPEG" }
            $EncoderParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
            $EncoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, $Quality)
            
            $NewImg.Save($OutputPath, $Encoder, $EncoderParams)
            
            # 清理
            $Graphics.Dispose()
            $NewImg.Dispose()
            $img.Dispose()
            $EncoderParams.Dispose()
            
            $Processed++
            Write-Host "✓ $($Image.Name) -> ${NewWidth}x${NewHeight}" -ForegroundColor Green
        }
        catch {
            $Failed++
            Write-Host "✗ $($Image.Name) - $($_.Exception.Message)" -ForegroundColor Red
        }
    }
    
    Write-Host "`n========================================" -ForegroundColor Cyan
    Write-Host "处理完成!" -ForegroundColor Green
    Write-Host "成功: $Processed" -ForegroundColor Green
    Write-Host "失败: $Failed" -ForegroundColor $(if($Failed -gt 0){"Red"}else{"Green"})
    Write-Host "输出: $OutputFolder" -ForegroundColor Cyan
    Write-Host "========================================`n" -ForegroundColor Cyan
    
    # 打开输出文件夹
    Start-Process explorer.exe $OutputFolder
}
else {
    Write-Host "✗ 需要 .NET Framework 支持图片处理" -ForegroundColor Red
    Write-Host "建议安装 ImageMagick 获得更好体验:" -ForegroundColor Yellow
    Write-Host "  winget install ImageMagick.ImageMagick" -ForegroundColor Cyan
}
