$solution_dir = $args[0]

$plugin_name = Get-ChildItem -Path . -Filter plugin.cs -Recurse -ErrorAction SilentlyContinue -Force | ForEach-Object {Get-Content $_.FullName} | % {if ($_ -match "BepInPlugin") {$plugin_vars=$_.Split(','); $plugin_vars[1]}}
$plugin_name = $plugin_name.substring(1).ToLower().Replace(' ', '-').replace('"', '')
$assembly_name = Get-ChildItem -Path . -Filter *.csproj -Recurse -ErrorAction SilentlyContinue -Force | ForEach-Object {Get-Content $_.FullName} | % {if ($_ -match "AssemblyName") {$csproj_vars=$_.Split('>'); $csproj_vars[1].Split('<')[0]}}

$dll_build = "$solution_dir\$assembly_name\bin\Debug\netstandard2.1\$assembly_name.dll"

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
    $plugin_folder = "$thunderstore_profiles\$profile\BepInEx\plugins\$plugin_name"

    Write-Host "Creating folder $plugin_folder"
    New-Item -ItemType Directory -Force -Path "$plugin_folder"

    Write-Host "Copying $dll_build to $plugin_folder"
    Copy-Item -Path "$dll_build" -Destination "$plugin_folder"
}
