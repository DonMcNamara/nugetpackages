# Oh, this is a giant pain in the ass. How do I get a COM interface instance?
# http://msdn.microsoft.com/en-us/library/windows/desktop/hh437965(v=VS.85).aspx

function Create-Shortcut
{
    $shell = New-Object -ComObject 'Wscript.Shell'
    $shortcut = $shell.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = $targetPath  
    $shortcut.WorkingDirectory = $content
    #$shortcut.IconLocation = $iconPath
    $shortcut.Save()
}

try 
{ 
    $name    = 'minecraft'
    $tools   = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
    $content = Join-Path (Split-path $tools) 'content'

    Get-ChocolateyWebFile "$name" "$content" 'https://s3.amazonaws.com/MinecraftDownload/launcher/Minecraft.exe'

    $guid = [guid]::NewGuid()
    
    # Create the special Game Explorer folders
    $gamesEx = "$ENV:LOCALAPPDATA\Microsoft\Windows\GameExplorer"
    $gameDir = "$gamesEx\{$guid}\PlayTasks\0"
    New-Item "$gameDir" -Type Directory

    # Create the Play shortcut in the new folder
    $targetPath   = Join-Path $content 'Minecraft.exe'
    $shortcutPath = Join-Path $gameDir 'Play.lnk'
    Create-Shortcut
    
    # Add the necessary registry key/values
    $gamesExReg = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameUX\S-1-5-21-1069610301-324996817-3984272044-1000"
    $gameReg    = "$gamesExReg\{$guid}"
    New-Item "$gameReg"
    
    New-ItemProperty $gameReg -name "AppExePath"            -value "$shortcutPath"
    New-ItemProperty $gameReg -name "ApplicationId"         -value "{$guid}"
    New-ItemProperty $gameReg -name "ConfigApplicationPath" -value "$content"
    New-ItemProperty $gameReg -name "ConfigInstallType"     -value "4"
    New-ItemProperty $gameReg -name "Title"                 -value "Minecraft"
    
    Write-ChocolateySuccess "$name"
} 
catch 
{
    Write-ChocolateyFailure "$name" "$($_.Exception.Message)"
    throw 
}