try 
{ 
    $name    = 'minecraft'
    $webfile = 'https://s3.amazonaws.com/MinecraftDownload/launcher/Minecraft.exe'
    
    $tools   = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
    $content = Join-Path (Split-path $tools) 'content'

    Get-ChocolateyWebFile $name "$content\Minecraft.exe" $webfile

    .\Install-Game.ps1 -binaryPath "$tools\Minecraft.dll" `
                       -installDirectory "$content" `
                       -installScope 3 #AllUsers
    
    Write-ChocolateySuccess $name
} 
catch 
{
    Write-ChocolateyFailure $name "$($_.Exception.Message)"
    throw 
}