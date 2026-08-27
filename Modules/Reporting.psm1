Set-StrictMode -Version Latest

function Export-StudentProvisioningReport {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [array]$Results,

        [Parameter(Mandatory)]
        [string]$Path
    )

    $directory = Split-Path -Parent $Path

    if ($directory -and -not (Test-Path $directory)) {
        New-Item -ItemType Directory -Path $directory -Force | Out-Null
    }

    $Results | Export-Csv -Path $Path -NoTypeInformation
    Write-Host "Report written to: $Path"
}

Export-ModuleMember -Function Export-StudentProvisioningReport