@ECHO OFF

:: You cannot generate the GDF header/resource from the command line.
:: Use the GDF Editor tool included in the DirectX SDK to generate 
:: those files.

SET gdf=%~dp0\gdf
SET src=%~dp0\src
SET bin=%~dp0\bin

:: Load the Visual Studio Command 2010 tools
SET vcvars="C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\vcvarsall.bat"
CALL %vcvars% x86

:: Compile the resource file
RC "%gdf%\Minecraft.rc"

:: Copy it into the csproj properties
COPY /Y "%gdf%\Minecraft.res" "%src%\Properties"

:: And build the project
SET msbuild="%windir%\Microsoft.NET\Framework\v4.0.30319\msbuild.exe"
%msbuild% "%src%\Minecraft.csproj" /property:Configuration=Release;Platform=x86;OutputPath="%bin%" /verbosity:minimal

PAUSE