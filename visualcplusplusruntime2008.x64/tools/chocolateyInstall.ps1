try
{
    $name = 'visualcplusplusruntime2008'
    $url  = 'http://download.microsoft.com/download/d/2/4/d242c3fb-da5a-4542-ad66-f9661d0a8d19/vcredist_x64.exe'

    Install-ChocolateyPackage $name 'EXE' '/Q' $url

    'Applying fix for Connect issue #316557 (http://connect.microsoft.com/VisualStudio/feedback/details/316557/)'
    $drive = Split-Path -Path $MyInvocation.MyCommand.Definition -Qualifier
    @('eula.1028.txt','eula.1031.txt','eula.1033.txt','eula.1036.txt','eula.1040.txt','eula.1041.txt','eula.1042.txt','eula.2052.txt','eula.3082.txt','globdata.ini','install.exe','install.ini','install.res.1028.dll','install.res.1031.dll','install.res.1033.dll','install.res.1036.dll','install.res.1040.dll','install.res.1041.dll','install.res.1042.dll','install.res.2052.dll','install.res.3082.dll','vcredist.bmp','VC_RED.cab','VC_RED.MSI') | %{
        Remove-Item (Join-Path $drive $_)
    }

    Write-ChocolateySuccess $name
}
catch
{
    Write-ChocolateyFailure $name "$($_.Exception.Message)"
    throw 
}