try 
{ 
    $name    = 'cmake.commandline'
    $url     = 'http://www.cmake.org/files/v2.8/cmake-2.8.7-win32-x86.zip'
    $tools   = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
    $content = Join-Path (Split-Path $tools) 'content'

    Install-ChocolateyZipPackage $name $url $content
    
    # Drop some of these EXEs off the radar for chocolatey
    $bin  = Join-Path $content 'cmake-2.8.7-win32-x86\bin'
    $gui  = Join-Path $bin 'cmake-gui.exe'
    $test = Join-Path $bin 'ctest.exe'
    $pack = Join-Path $bin 'cpack.exe'
    $com  = Join-Path $bin 'cmw9xcom.exe'
    
    @($gui,$test,$pack,$com) | %{ Rename-Item $_ "$_.bak" }
} 
catch 
{
    Write-ChocolateyFailure $name "$($_.Exception.Message)"
    throw 
}