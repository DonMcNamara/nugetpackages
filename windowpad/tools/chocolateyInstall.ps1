function Create-Shortcut
{
  $shell = New-Object -ComObject 'Wscript.Shell'
  $shortcut = $shell.CreateShortcut($shortcutPath)
  $shortcut.TargetPath = $targetPath  
  $shortcut.WorkingDirectory = $content
  #$shortcut.IconLocation = $iconPath
  $shortcut.Save()
}

function Start-Script
{
  & $shortcutPath
}

try 
{ 
  $name = 'windowpad'
  
  $startup      = "$ENV:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"

  $tools        = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
  $content      = Join-Path (Split-Path $tools) 'content'

  $targetPath   = Join-Path "$content" 'WindowPad.exe'
  $iconPath     = Join-Path "$content" 'testnamingmode_16.ico'
  $shortcutPath = Join-Path "$startup" 'WindowPad.lnk'
  
  Install-ChocolateyZipPackage "$name" 'http://www.autohotkey.net/~Lexikos/WindowPad.zip' "$content"
 
  Create-Shortcut
  Start-Script
 
  Write-ChocolateySuccess "$name"
} 
catch 
{
  Write-ChocolateyFailure "$name" "$($_.Exception.Message)"
  throw 
}