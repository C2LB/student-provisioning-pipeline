BeforeAll {
    Import-Module "$PSScriptRoot/../Modules/Validation.psm1" -Force
}

Describe 'Test-StudentInput' {
    It 'accepts a complete student record' {
        $student = [pscustomobject]@{
            StudentName = 'Avery Johnson'
            Email       = 'avery.johnson@contoso.example'
        }

        $result = Test-StudentInput -Student $student

        $result.IsValid | Should -BeTrue
        $result.Errors | Should -HaveCount 0
    }

    It 'rejects a missing student name' {
        $student = [pscustomobject]@{
            StudentName = ''
            Email       = 'avery.johnson@contoso.example'
        }

        $result = Test-StudentInput -Student $student

        $result.IsValid | Should -BeFalse
        $result.Errors | Should -Contain 'StudentName is required.'
    }

    It 'rejects an invalid email address' {
        $student = [pscustomobject]@{
            StudentName = 'Avery Johnson'
            Email       = 'not-an-email'
        }

        $result = Test-StudentInput -Student $student

        $result.IsValid | Should -BeFalse
        $result.Errors | Should -Contain 'Email format is invalid.'
    }

    It 'returns every applicable validation error' {
        $student = [pscustomobject]@{
            StudentName = ''
            Email       = ''
        }

        $result = Test-StudentInput -Student $student

        $result.IsValid | Should -BeFalse
        $result.Errors | Should -HaveCount 2
        $result.Errors | Should -Contain 'StudentName is required.'
        $result.Errors | Should -Contain 'Email is required.'
    }
}
