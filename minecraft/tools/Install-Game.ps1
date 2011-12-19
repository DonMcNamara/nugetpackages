<#
    enum GAME_INSTALL_SCOPE
        GIS_NOT_INSTALLED = 1,
        GIS_CURRENT_USER  = 2,
        GIS_ALL_USERS     = 3,
#>

param($binaryPath, $installDirectory, $installScope)

$signature = @"
[DllImport("GameuxInstallHelper.dll")]
public static extern void GameExplorerInstallW(
    string binaryPath,
    string installDirectory,
    int installScope);
"@

$type = Add-Type $signature -Name "GameUx" -Namespace "InstallGame" -PassThru
$type::GameExplorerInstallW($binaryPath, $installDirectory, $installScope)