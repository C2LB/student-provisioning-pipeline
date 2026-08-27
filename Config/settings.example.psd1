@{
    Organization = "Contoso Education"

    Tenant = @{
        TenantId = "00000000-0000-0000-0000-000000000000"
        Domain   = "contoso.example"
    }

    Student = @{
        UsageLocation = "US"
        LicenseProfile = "Microsoft 365 A3 for Students"
        DefaultGroup   = "Students-All"
    }

    Paths = @{
        Reports = "./Reports"
        Logs    = "./Logs"
    }
}