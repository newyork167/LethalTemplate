# Write a function to show a custom input box
function Show-CustomInputBox {
    param(
        [string]$Title = 'Input Box',
        [string]$Message = 'Enter your input:',
        [string]$DefaultText = 'Default Text'
    )
    Add-Type -AssemblyName Microsoft.VisualBasic
    return [Microsoft.VisualBasic.Interaction]::InputBox($Message, $Title, $DefaultText)
}

$plugin_name = Show-CustomInputBox -title "Lethal Company Plugin Setup" -message "Enter the name of your plugin" -defaultText "LethalTemplate"
Write-Host "Changing plugin name to: $plugin_name"

$plugin_name_pascal_case = $plugin_name -replace '(\w)(\w*)', { $args[0].ToUpper() + $args[1].ToLower() }

$plugin_name_lower_case = $plugin_name -replace ' ', '-'
$plugin_name_lower_case = $plugin_name_lower_case.ToLower()

$name = Show-CustomInputBox -title "Lethal Company Plugin Setup" -message "Enter your name" -defaultText "newyork167"
Write-Host "Changing plugin name to: $plugin_name"

# Replace contents of all files with the new plugin name
(Get-Content .\LethalTemplate\LethalTemplate.csproj).Replace('LethalTemplate', $plugin_name_pascal_case) | Set-Content .\LethalTemplate\LethalTemplate.csproj
(Get-Content .\LethalTemplate\Patches\HudManagerPatch.csproj).Replace('LethalTemplate', $plugin_name_pascal_case) | Set-Content .\LethalTemplate\Patches\HudManagerPatch.csproj
(Get-Content .\LethalTemplate\plugin.cs).Replace('LethalTemplate', $plugin_name_pascal_case) | Set-Content .\LethalTemplate\plugin.cs
(Get-Content .\LethalTemplate\plugin.cs).Replace('org.newyork167.plugins.lethaltemplate', "org.$name.plugins.$plugin_name_lower_case") | Set-Content .\LethalTemplate\plugin.cs
(Get-Content .\LethalTemplate\plugin.cs).Replace('Example Plug-In', "$plugin_name") | Set-Content .\LethalTemplate\plugin.cs
