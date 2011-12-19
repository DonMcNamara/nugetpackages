try 
{ 
    $name    = 'minecraft'
    $webfile = 'https://s3.amazonaws.com/MinecraftDownload/launcher/Minecraft.exe'
    
    $tools   = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
    $content = Join-Path (Split-Path $tools) 'content'
    $exepath = Join-Path $content 'Minecraft.exe'

    Get-ChocolateyWebFile $name $exepath $webfile
    
    $binaryPath       = Join-Path $tools 'Minecraft.dll'
    $installDirectory = $content
    $installScope     = 3 # AllUsers

    # Dirty hack so that `DllImport` can find the GameUx dll.
    $ENV:PATH += ";$tools"
    
    $signature = @"
[DllImport("GameuxInstallHelper.dll")]
public static extern int GameExplorerInstall(
    string binaryPath,
    string installDirectory,
    int    installScope);
"@

    $type = Add-Type $signature -Name "GameUx" -Namespace "InstallGame" -PassThru
    $result = $type::GameExplorerInstall($binaryPath, $installDirectory, $installScope)
    
    "Result: $result"
    
    $game = Get-WmiObject Game -Namespace 'root\cimv2\applications\games' `
                | ?{ $_.Name -eq 'Minecraft' }
                
    if(-not $game) { throw 'Minecraft was not installed correctly.' }
    
    Write-ChocolateySuccess $name
} 
catch 
{
    Write-ChocolateyFailure $name "$($_.Exception.Message)"
    throw 
}