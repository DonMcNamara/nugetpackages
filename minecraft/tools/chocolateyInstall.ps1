try 
{ 
    $name    = 'minecraft'
    $url     = 'https://s3.amazonaws.com/MinecraftDownload/launcher/Minecraft.exe'
    
    $tools   = Split-Path $MyInvocation.MyCommand.Definition
    $content = Join-Path (Split-Path $tools) 'content'
    $exepath = Join-Path $content 'Minecraft.exe'

    Get-ChocolateyUrl $name $exepath $url
    
    Write-ChocolateySuccess $name
} 
catch 
{
    Write-ChocolateyFailure $name $($_.Exception.Message)
    throw 
}