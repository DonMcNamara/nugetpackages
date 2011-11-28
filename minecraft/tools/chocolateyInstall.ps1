try 
{ 
    $name    = 'minecraft'
    $tools   = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
    $content = Join-Path (Split-path $tools) 'content'

    Get-ChocolateyWebFile "$name" "$content" 'https://s3.amazonaws.com/MinecraftDownload/launcher/Minecraft.exe'
    Write-ChocolateySuccess "$name"
} 
catch 
{
    Write-ChocolateyFailure "$name" "$($_.Exception.Message)"
    throw 
}