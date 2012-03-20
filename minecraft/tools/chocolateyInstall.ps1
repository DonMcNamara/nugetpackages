try 
{ 
    $name    = 'minecraft'
    $url     = 'https://s3.amazonaws.com/MinecraftDownload/launcher/Minecraft.exe'
    
    $tools   = Split-Path $MyInvocation.MyCommand.Definition
    $content = Join-Path (Split-Path $tools) 'content'
    $exepath = Join-Path $content 'Minecraft.exe'

    #Get-ChocolateyUrl $name $exepath $url
    
    $binaryPath       = Join-Path $content 'Minecraft.dll'
    $installDirectory = $content
    $installScope     = 3 # AllUsers
    
    # HACK so DllImport can find the Gameux dll
    $ENV:PATH += ";$tools"
    
    $signature = @"
[DllImport("GameuxInstallHelper.dll", CharSet = CharSet.Auto)]
public static extern int GameExplorerInstall(
    [MarshalAs(UnmanagedType.LPTStr)]string binaryPath,
    [MarshalAs(UnmanagedType.LPTStr)]string installDirectory,
    int installScope);
"@
    
    $type = Add-Type -Name "InstallGame" `
                     -Namespace "GameUx" `
                     -MemberDefinition $signature `
                     -PassThru
    
    $result = $type::GameExplorerInstall($binaryPath, $installDirectory, $installScope)
    
    $ns   = 'root\cimv2\applications\games'
    $game = Get-WmiObject Game -Namespace $ns | ?{ $_.Name -eq 'Minecraft' }
                
    if(-not $game) { 
        throw "Minecraft was not installed correctly. Result: $result"
    }
    
    #Write-ChocolateySuccess $name
} 
catch 
{
    #Write-ChocolateyFailure $name $($_.Exception.Message)
    throw 
}