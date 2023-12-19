function Get-Folder($initialDirectory="", $description="Select Folder") {
    Add-Type -AssemblyName System.Windows.Forms
    $dialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $dialog.Description  = $description
    $dialog.SelectedPath = $initialDirectory
    $dialog.RootFolder   = $RootFolder
    $dialog.ShowNewFolderButton = if ($ShowNewFolderButton) { $true } else { $false }
    $selected = $null

    # force the dialog TopMost
    # Since the owning window will not be used after the dialog has been 
    # closed we can just create a new form on the fly within the method call
    $result = $dialog.ShowDialog((New-Object System.Windows.Forms.Form -Property @{TopMost = $true }))
    if ($result -eq [Windows.Forms.DialogResult]::OK){
        $selected = $dialog.SelectedPath
    }
    # clear the FolderBrowserDialog from memory
    $dialog.Dispose()
    # return the selected folder
    $selected
}

$thunderstore_installed = if ((get-package Thunderstore* | Measure-Object).count -gt 0) { $true } else { $false }
if (-not $thunderstore_installed) {
    Write-Host "Thunderstore Mod Manager not installed. Please install it from https://www.overwolf.com/oneapp/thunderstore-mod-manager"
    exit -1
}

$drive_letters = (Get-PSDrive).Name -match '^[a-z]$'
$lethal_company_folder = $drive_letters | ForEach-Object {
    # If this drive is C, check if the folder is in Program Files (x86)
    if ($_ -eq 'C') {
        Write-Host "Checking if C:/Program Files (x86)/Steam/steamapps/common/Lethal Company exists"
        if (Test-Path "C:/Program Files (x86)/Steam/steamapps/common/Lethal Company") {
            return "C:/Program Files (x86)/Steam/steamapps/common/Lethal Company"
        }
    }

    Write-Host "Checking if '$($_):/SteamLibrary/steamapps/common/Lethal Company' exists"
    if (Test-Path "$($_):/SteamLibrary/steamapps/common/Lethal Company") {
        return "$($_):/SteamLibrary/steamapps/common/Lethal Company"
    }
}

# If we didn't find the folder, ask the user to select it
if (-not $lethal_company_folder) {
    $lethal_company_folder = Get-Folder -description "Select Lethal Company folder (e.g. C:\Program Files (x86)\Steam\steamapps\common\Lethal Company)" -initialDirectory "C:\Program Files (x86)\Steam\steamapps\common"
}

$thunderstore_profile_folder = Get-Folder -description "Select Thunderstore Profile folder (e.g. $Env:USERPROFILE\AppData\Roaming\Thunderstore Mod Manager\DataFolder\LethalCompany\profiles\Modding)" -initialDirectory "$Env:USERPROFILE\AppData\Roaming\Thunderstore Mod Manager\DataFolder\LethalCompany\profiles\"

(Get-Content .\LethalTemplate\LethalTemplate.csproj).Replace('LETHAL_COMPANY_FOLDER', $lethal_company_folder) | Set-Content .\LethalTemplate\LethalTemplate.csproj
(Get-Content .\LethalTemplate\LethalTemplate.csproj).Replace('THUNDERSTORE_PROFILE_FOLDER', $thunderstore_profile_folder) | Set-Content .\LethalTemplate\LethalTemplate.csproj

Push-Location
cd LethalTemplate
dotnet add package BepInEx.PluginInfoProps --version 2.1.0
dotnet add package BepInEx.Analyzers --version 1.0.8
dotnet add package Lib.Harmony --version 2.2.2
Pop-Location

.\scripts\rename_plugin.ps1
