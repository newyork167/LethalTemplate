$solution_dir = $args[0]

# Get NetcodePatcher
# https://github.com/EvaisaDev/UnityNetcodeWeaver/releases/download/2.4.0/NetcodePatcher-2.4.0.zip
$latest_release = Invoke-RestMethod https://github.com/EvaisaDev/UnityNetcodeWeaver/releases/latest | grep -i "NetcodePatcher-*" | head -n 1 | awk '{print $2; }'
$latest_release_number = $latest_release.Split('-')[-1]

Write-Host "Latest NetcodePatcher release: $latest_release_number"

# Check if "$solution_dir\tools\$latest_release.zip" exists
if (Test-Path "$solution_dir\tools\$latest_release.zip") {
    Write-Host "NetcodePatcher $latest_release already downloaded"
    exit 0
}

# If not, download it
$download_url = "https://github.com/EvaisaDev/UnityNetcodeWeaver/releases/download/$latest_release_number/$latest_release.zip"
$download_path = "$solution_dir\tools\$latest_release.zip"
Write-Host "Downloading NetcodePatcher $latest_release from $download_url to $download_path"
Invoke-WebRequest -Uri $download_url -OutFile $download_path

# Unzip download_path to $solution_dir\tools\$latest_release
Write-Host "Unzipping $download_path to $solution_dir\tools\$latest_release_number"
Expand-Archive -Path $download_path -DestinationPath "$solution_dir\tools\NetcodePatcher-$latest_release_number" -Force

# Remove "$solution_dir\tools\NetcodePatcher" if it exists
if (Test-Path "$solution_dir\tools\NetcodePatcher") {
    Remove-Item -Path "$solution_dir\tools\NetcodePatcher" -Recurse -Force
}

# rename to NetcodePatcher 
Rename-Item -Path "$solution_dir\tools\NetcodePatcher-$latest_release_number" -NewName "$solution_dir\tools\NetcodePatcher"

# Get-Content .\LethalTemplate\LethalTemplate.csproj and grab a single line that contains \Lethal Company_Data\Managed
$hint_path = Get-Content .\LethalTemplate\LethalTemplate.csproj | Select-String -Pattern "Lethal Company_Data\\Managed" | Select-Object -First 1

# Replace everything up to and including <HintPath> with an empty string, and everything </HintPath> and after with an empty string
$hint_path = $hint_path -replace ".*<HintPath>", ""
$hint_path = $hint_path -replace "</HintPath>.*", ""
$lethal_company_managed_path = $hint_path.Substring(0, $hint_path.LastIndexOf("\"))

# Copy everything from $lethal_company_managed_path to $solution_dir\tools\NetcodePatcher\deps
Write-Host "Copying $lethal_company_managed_path to $solution_dir\tools\NetcodePatcher\deps"
Copy-Item -Path "$lethal_company_managed_path\*" -Destination "$solution_dir\tools\NetcodePatcher\deps" -Recurse -Force