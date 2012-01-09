$name = 'visualcplusplusruntime2010'
$url  = 'http://download.microsoft.com/download/5/B/C/5BC5DBB3-652D-4DCE-B14A-475AB85EEF6E/vcredist_x86.exe'
Install-ChocolateyPackage $name 'EXE' '/Q' $url