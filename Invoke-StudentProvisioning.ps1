[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter()]
    [string]$InputCsv = "./Samples/students.example.csv",

    [Parameter()]
    [string]$ConfigPath = "./Config/settings.example.psd1"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Import-Module "$PSScriptRoot/Modules/Validation.psm1" -Force
Import-Module "$PSScriptRoot/Modules/Graph.psm1" -Force
Import-Module "$PSScriptRoot/Modules/Reporting.psm1" -Force

$config = Import-PowerShellDataFile -Path $ConfigPath
$students = Import-Csv -Path $InputCsv
$results = [System.Collections.Generic.List[object]]::new()

foreach ($student in $students) {
    $validation = Test-StudentInput -Student $student

    if (-not $validation.IsValid) {
        $results.Add([pscustomobject]@{
            StudentName = $student.StudentName
            Email       = $student.Email
            Status      = "Skipped"
            Message     = ($validation.Errors -join "; ")
        })
        continue
    }

    try {
        $result = Invoke-StudentCloudProvisioning `
            -Student $student `
            -Configuration $config `
            -WhatIf:$WhatIfPreference

        if ($null -ne $result) {
            $results.Add($result)
        }
    }
    catch {
        $results.Add([pscustomobject]@{
            StudentName = $student.StudentName
            Email       = $student.Email
            Status      = "Failed"
            Message     = $_.Exception.Message
        })
    }
}

$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$reportPath = Join-Path $config.Paths.Reports "StudentProvisioning-$timestamp.csv"

Export-StudentProvisioningReport -Results $results -Path $reportPath
$results | Format-Table -AutoSize