$solution_dir = $args[0]
$dll_build = "$solution_dir\LethalCompanyTemplate\bin\Debug\netstandard2.1\LethalCompanyTemplate.dll"

$profiles_to_copy_to = @(
    "Modding"
)

$thunderstore_profiles = "$Env:USERPROFILE\AppData\Roaming\Thunderstore Mod Manager\DataFolder\LethalCompany\profiles\"

if (-not (Test-Path -Path $thunderstore_profiles)) {
    Write-Host "Thunderstore folder not found: $thunderstore_profiles"
    Write-Host "Please install Thunderstore Mod Manager or change the profile names in scripts/copy_to_thunderstore.ps1"
    exit -1
}

$profiles_to_copy_to | ForEach-Object {
    $profile = $_
    $thunderstore_plugins = "$thunderstore_profiles\$profile\BepInEx\plugins"
    $lethal_progression_plugin_folder = "$thunderstore_plugins\lethal-progression"

    Write-Host "Thunderstore folder: $thunderstore_plugins"
    Write-Host "Creating folder $lethal_progression_plugin_folder"
    New-Item -ItemType Directory -Force -Path "$lethal_progression_plugin_folder"

    Write-Host "Copying $dll_build to $lethal_progression_plugin_folder"
    Copy-Item -Path "$dll_build" -Destination "$lethal_progression_plugin_folder"
}
