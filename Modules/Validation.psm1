Set-StrictMode -Version Latest

function Test-StudentInput {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [pscustomobject]$Student
    )

    $errors = [System.Collections.Generic.List[string]]::new()

    if ([string]::IsNullOrWhiteSpace($Student.StudentName)) {
        $errors.Add("StudentName is required.")
    }

    if ([string]::IsNullOrWhiteSpace($Student.Email)) {
        $errors.Add("Email is required.")
    }
    elseif ($Student.Email -notmatch '^[^@\s]+@[^@\s]+\.[^@\s]+$') {
        $errors.Add("Email format is invalid.")
    }

    [pscustomobject]@{
        IsValid = ($errors.Count -eq 0)
        Errors  = @($errors)
    }
}

Export-ModuleMember -Function Test-StudentInput