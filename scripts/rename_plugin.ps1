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

function ConvertToWords {
    param(
        [Parameter(Mandatory=$true)]
        [int]$number
    )

    # Define arrays for words representation
    $ones = @("zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine")
    $teens = @("ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen")
    $tens = @("dummy", "ten", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety")

    if ($number -lt 0 -or $number -gt 999999) {
        Write-Host "Number out of range. Please enter a number between 0 and 999999."
    }

    if ($number -ge 0 -and $number -lt 10) {
        return $ones[$number].replace(' ', '-')
    }

    if ($number -ge 10 -and $number -lt 20) {
        return $teens[$number - 10].replace(' ', '-')
    }

    if ($number -ge 20 -and $number -lt 100) {
        $tensDigit = [math]::Floor($number / 10)
        $onesDigit = $number % 10

        if ($onesDigit -eq 0) {
            return $tens[$tensDigit].replace(' ', '-')
        } else {
            return "$($tens[$tensDigit])-$($ones[$onesDigit])".replace(' ', '-')
        }
    }

    if ($number -ge 100 -and $number -lt 1000) {
        $hundredsDigit = [math]::Floor($number / 100)
        $remainder = $number % 100
        $remainderInWords = ConvertToWords $remainder

        if ($remainder -eq 0) {
            return "$($ones[$hundredsDigit]) hundred".replace(' ', '-')
        } else {
            return "$($ones[$hundredsDigit]) hundred $($remainderInWords)".replace(' ', '-')
        }
    }

    if ($number -ge 1000 -and $number -lt 1000000) {
        $thousandsDigit = [math]::Floor($number / 1000)
        $remainder = $number % 1000
        $remainderInWords = ConvertToWords $remainder

        if ($remainder -eq 0) {
            return "$($ones[$thousandsDigit]) thousand".replace(' ', '-')
        } else {
            return "$($ones[$thousandsDigit]) thousand $($remainderInWords)".replace(' ', '-')
        }
    }
}

$plugin_name = Show-CustomInputBox -title "Lethal Company Plugin Setup" -message "Enter the name of your plugin" -defaultText "Lethal Template"
Write-Host "Changing plugin name to: $plugin_name"

#$plugin_name_pascal_case = $plugin_name -replace '(?:^|_)(\p{L})', { $_.Groups[1].Value.ToUpper() }
$plugin_name_pascal_case = [regex]::Replace(
        $plugin_name,
        '\d+',
        { ConvertToWords $args[0].Value }
).replace('-', '')

$plugin_name_pascal_case = [regex]::Replace(
    $plugin_name_pascal_case,
    '(?i)(?:^|_)(\p{L})',
    { $args[0].Groups[1].Value.ToUpper() }
).replace(' ', '').replace('-', '')

# Replace all numbers in $plugin_name_pascal_case with a function call to ConvertToWords
write-host "Plugin name in PascalCase: $plugin_name_pascal_case"

$plugin_name_lower_case = $plugin_name -replace ' ', '-'
$plugin_name_lower_case = $plugin_name_lower_case.ToLower()

$name = Show-CustomInputBox -title "Lethal Company Plugin Setup" -message "Enter your name" -defaultText "newyork167"
Write-Host "Changing plugin dev name to: $name"

# Replace contents of all files with the new plugin name
(Get-Content .\LethalTemplate\Patches\HudManagerPatch.cs).Replace('namespace LethalTemplate', "namespace $plugin_name_pascal_case") | Set-Content .\LethalTemplate\Patches\HudManagerPatch.cs

(Get-Content .\LethalTemplate\plugin.cs).Replace('namespace LethalTemplate', "namespace $plugin_name_pascal_case") | Set-Content .\LethalTemplate\plugin.cs
(Get-Content .\LethalTemplate\plugin.cs).Replace('org.newyork167.plugins.lethaltemplate', "org.$name.plugins.$plugin_name_lower_case") | Set-Content .\LethalTemplate\plugin.cs
(Get-Content .\LethalTemplate\plugin.cs).Replace('Example Plug-In', "$plugin_name") | Set-Content .\LethalTemplate\plugin.cs

(Get-Content .\LethalTemplate\LethalTemplate.csproj).Replace('LethalTemplate', "$plugin_name_pascal_case") | Set-Content .\LethalTemplate\LethalTemplate.csproj
