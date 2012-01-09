try
{
    $name = 'visualcplusplusruntime2005.x64'
    $url  = 'http://download.microsoft.com/download/9/1/4/914851c6-9141-443b-bdb4-8bad3a57bea9/vcredist_x64.exe'

    Install-ChocolateyPackage $name 'EXE' '/Q' $url

    # Apply this KB fix manually (http://support.microsoft.com/kb/927665).
    $dll    = 'msdia80.dll'
    $drive  = Split-Path -Path $MyInvocation.MyCommand.Definition -Qualifier
    $source = Join-Path $drive $dll
    $shared = Join-Path $ENV:CommonProgramFiles 'Microsoft Shared\VC'
    $target = Join-Path $shared $dll
    
    "Applying KB927665 to $source"
    Move-Item $source $target -Force
    regsvr32 $target /s

    Write-ChocolateySuccess $name
}
catch
{
    Write-ChocolateyFailure $name "$($_.Exception.Message)"
    throw 
}