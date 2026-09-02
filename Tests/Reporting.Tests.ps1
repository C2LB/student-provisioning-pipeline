BeforeAll {
    Import-Module "$PSScriptRoot/../Modules/Reporting.psm1" -Force
}

Describe 'Export-StudentProvisioningReport' {
    It 'creates the output directory and exports structured results' {
        $reportPath = Join-Path $TestDrive 'nested' 'StudentProvisioning.csv'
        $results = @(
            [pscustomobject]@{
                StudentName = 'Avery Johnson'
                Email       = 'avery.johnson@contoso.example'
                Status      = 'Simulated'
                Message     = 'Test result'
            }
        )

        Export-StudentProvisioningReport -Results $results -Path $reportPath

        $reportPath | Should -Exist
        $rows = @(Import-Csv -Path $reportPath)
        $rows | Should -HaveCount 1
        $rows[0].Status | Should -Be 'Simulated'
        $rows[0].Email | Should -Be 'avery.johnson@contoso.example'
    }

    It 'writes a valid empty report when no results are supplied' {
        $reportPath = Join-Path $TestDrive 'empty' 'StudentProvisioning.csv'

        Export-StudentProvisioningReport -Results @() -Path $reportPath

        $reportPath | Should -Exist
        @(Import-Csv -Path $reportPath) | Should -HaveCount 0
    }
}
