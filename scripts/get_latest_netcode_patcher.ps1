$solution_dir = $args[0]

# Get NetcodePatcher
# https://github.com/EvaisaDev/UnityNetcodeWeaver/releases/download/2.4.0/NetcodePatcher-2.4.0.zip
$latest_release = Invoke-RestMethod https://github.com/EvaisaDev/UnityNetcodeWeaver/releases/latest | grep -i "NetcodePatcher-*" | head -n 1 | awk '{print $2; }'
$latest_release_number = $latest_release.Split('-')[-1]

# Check if "$solution_dir\tools\$latest_release.zip" exists
if (Test-Path "$solution_dir\tools\$latest_release.zip") {
    Write-Host "NetcodePatcher $latest_release already downloaded"
    exit 0
}

# If not, download it
$download_url = "https://github.com/EvaisaDev/UnityNetcodeWeaver/releases/download/$latest_release_number/$latest_release_number.zip"
$download_path = "$solution_dir\tools\$latest_release.zip"
Invoke-WebRequest -Uri $download_url -OutFile $download_path

# Unzip download_path to $solution_dir\tools
Expand-Archive -Path $download_path -DestinationPath "$solution_dir\tools"

# Remove "$solution_dir\tools\NetcodePatcher" if it exists
if (Test-Path "$solution_dir\tools\NetcodePatcher") {
    Remove-Item -Path "$solution_dir\tools\NetcodePatcher" -Recurse -Force
}

# rename to NetcodePatcher 
Rename-Item -Path "$solution_dir\tools\NetcodePatcher-$latest_release_number" -NewName "$solution_dir\tools\NetcodePatcher"