:: You cannot generate the GDF header/resource from the command line.
:: Use the GDF Editor tool included in the DirectX SDK to generate 
:: those files.

:: Load the Visual Studio Command Prompt 2010
CALL "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\vcvarsall.bat" x86

:: Compile the resource file
rc "%~dp0\Minecraft.rc"

PAUSE