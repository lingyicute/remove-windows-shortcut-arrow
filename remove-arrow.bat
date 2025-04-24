@echo off
set iconcache=%localappdata%\IconCache.db
set iconcache_x=%localappdata%\Microsoft\Windows\Explorer\iconcache*

cd /d "%~dp0"
taskkill /IM explorer.exe /F

echo.
echo 正在复制 blank.ico 到系统目录...
copy "blank.ico" "%windir%\Cursors\" >nul || (
    echo 错误：复制文件失败，请检查文件是否存在！
    pause
    exit /b
)

echo.
echo 正在导入注册表配置...
regedit /s "icon.reg" || (
    echo 错误：注册表导入失败！
    pause
    exit /b
)

echo.
echo 正在重建 IconCache.db...
echo.
taskkill /IM explorer.exe /F
timeout /t 2 >nul
del /A /F /Q "%iconcache%"
del /A /F /Q "%iconcache_x%"
taskkill /IM explorer.exe /F
del /A /F /Q "%iconcache%"
del /A /F /Q "%iconcache_x%"
echo.
echo 执行完成，即将重启资源管理器。
echo.
timeout /t 1 >nul
start explorer.exe