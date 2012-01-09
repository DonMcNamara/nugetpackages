$name = 'visualcplusplusruntime2010'
$url  = 'http://download.microsoft.com/download/3/2/2/3224B87F-CFA0-4E70-BDA3-3DE650EFEBA5/vcredist_x64.exe'
Install-ChocolateyPackage $name 'EXE' '/Q' $url