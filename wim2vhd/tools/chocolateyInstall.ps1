try 
{ 
    $name = 'wim2vhd'

    $tools   = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
    $content = Join-Path (Split-Path $tools) 'content'
    $bat     = "$ENV:CHOCOLATEYINSTALL\bin\wim2vhd.bat"

@"
@echo off
cscript "$content\wim2vhd.wsf" %*
"@ | Out-File $bat -encoding ASCII
    
    Write-ChocolateySuccess "$name"
} 
catch 
{
    Write-ChocolateyFailure "$name" "$($_.Exception.Message)"
    throw 
}