# YouTube Studio ショートカットキー セットアップ (Windows)
# Ctrl+Alt+Y でYouTube Studioを開く

$URL = "https://studio.youtube.com/channel/UCTLPmcqT0CK_LF905kJUzjg?c=UCTLPmcqT0CK_LF905kJUzjg"
$ShortcutPath = "$env:USERPROFILE\Desktop\YouTube Studio.lnk"

Write-Host "=== YouTube Studio ショートカットキー セットアップ ==="
Write-Host ""

# デスクトップにショートカットを作成
$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut($ShortcutPath)
$Shortcut.TargetPath = "cmd.exe"
$Shortcut.Arguments = "/c start `"`" `"$URL`""
$Shortcut.Hotkey = "CTRL+ALT+Y"
$Shortcut.WindowStyle = 7  # 最小化で起動（cmdウィンドウを隠す）
$Shortcut.Description = "YouTube Studio を開く"
$Shortcut.Save()

Write-Host "完了！"
Write-Host ""
Write-Host "========================================"
Write-Host "  ショートカットキー: Ctrl + Alt + Y"
Write-Host "  デスクトップに 'YouTube Studio' を作成しました"
Write-Host "========================================"
Write-Host ""
Write-Host "Ctrl+Alt+Y を押してYouTube Studioが開けば成功です！"
