param(
    [switch]$BuildInstaller
)

$ErrorActionPreference = "Stop"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Tarket Windows Release Builder" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

$projectRoot = (Resolve-Path "$PSScriptRoot\..").Path
Set-Location $projectRoot

Write-Host "`n[1/2] Building Flutter Windows Release..." -ForegroundColor Yellow
flutter build windows --release
if ($LASTEXITCODE -ne 0) {
    Write-Error "Flutter build failed with code $LASTEXITCODE"
    exit $LASTEXITCODE
}

Write-Host "Windows release build completed successfully." -ForegroundColor Green
$releaseDir = Join-Path $projectRoot "build\windows\x64\runner\Release"
Write-Host "Release binaries: $releaseDir" -ForegroundColor Gray

if ($BuildInstaller) {
    Write-Host "`n[2/2] Building Windows Installer with Inno Setup..." -ForegroundColor Yellow
    
    $isccCandidates = @(
        "iscc.exe",
        "$env:LOCALAPPDATA\Programs\Inno Setup 6\ISCC.exe",
        "$env:ProgramFiles (x86)\Inno Setup 6\ISCC.exe",
        "$env:ProgramFiles\Inno Setup 6\ISCC.exe"
    )
    
    $isccPath = $null
    foreach ($cand in $isccCandidates) {
        if ($cand -eq "iscc.exe") {
            $cmd = Get-Command "iscc.exe" -ErrorAction SilentlyContinue
            if ($cmd) {
                $isccPath = $cmd.Source
                break
            }
        } elseif (Test-Path $cand) {
            $isccPath = $cand
            break
        }
    }
    
    if (-not $isccPath) {
        Write-Error "Could not find Inno Setup Compiler (ISCC.exe). Please ensure Inno Setup 6 is installed."
        exit 1
    }
    
    Write-Host "Using Inno Setup compiler: $isccPath" -ForegroundColor Gray
    $issFile = Join-Path $projectRoot "installer.iss"
    
    if (-not (Test-Path $issFile)) {
        Write-Error "Installer script not found: $issFile"
        exit 1
    }
    
    & "$isccPath" "$issFile"
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Inno Setup compilation failed with code $LASTEXITCODE"
        exit $LASTEXITCODE
    }
    
    $installerPath = Join-Path $projectRoot "dist_installer\Tarket_Setup_v1.0.0.exe"
    Write-Host "`nInstaller built successfully!" -ForegroundColor Green
    Write-Host "Installer file: $installerPath" -ForegroundColor Cyan
}

Write-Host "`nAll operations completed successfully!" -ForegroundColor Green
