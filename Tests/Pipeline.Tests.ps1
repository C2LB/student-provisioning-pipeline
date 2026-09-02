Describe 'Student provisioning pipeline' {
    BeforeEach {
        $script:reportDirectory = Join-Path $TestDrive 'Reports'
        $script:logDirectory = Join-Path $TestDrive 'Logs'
        $script:configPath = Join-Path $TestDrive 'settings.test.psd1'
        $escapedReportDirectory = $script:reportDirectory.Replace("'", "''")
        $escapedLogDirectory = $script:logDirectory.Replace("'", "''")

        @"
@{
    Organization = 'Contoso Test'
    Tenant = @{
        TenantId = '00000000-0000-0000-0000-000000000000'
        Domain   = 'contoso.example'
    }
    Student = @{
        UsageLocation = 'US'
        LicenseProfile = 'Microsoft 365 A3 for Students'
        DefaultGroup   = 'Students-All'
    }
    Paths = @{
        Reports = '$escapedReportDirectory'
        Logs    = '$escapedLogDirectory'
    }
}
"@ | Set-Content -Path $script:configPath
    }

    It 'processes the fictional sample data and writes simulated results' {
        $pipelinePath = Join-Path $PSScriptRoot '..' 'Invoke-StudentProvisioning.ps1'
        $samplePath = Join-Path $PSScriptRoot '..' 'Samples' 'students.example.csv'

        & $pipelinePath -InputCsv $samplePath -ConfigPath $script:configPath | Out-Null

        $report = Get-ChildItem -Path $script:reportDirectory -Filter 'StudentProvisioning-*.csv'
        $report | Should -HaveCount 1

        $rows = @(Import-Csv -Path $report.FullName)
        $rows | Should -HaveCount 3
        $rows.Status | Should -Not -Contain 'Failed'
        $rows.Status | Should -Not -Contain 'Skipped'

        foreach ($row in $rows) {
            $row.Status | Should -Be 'Simulated'
        }
    }
}
