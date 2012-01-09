$name = 'visualcplusplusruntime2008'
$url  = 'http://download.microsoft.com/download/1/1/1/1116b75a-9ec3-481a-a3c8-1777b5381140/vcredist_x86.exe'
Install-ChocolateyPackage $name 'EXE' "/Q /T:`"$pwd\temp`"" $url