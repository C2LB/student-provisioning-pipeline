# Student Provisioning Pipeline

Production-inspired PowerShell automation for student identity provisioning in Microsoft 365.

> This repository is a clean-room portfolio implementation based on real operational experience. Organization-specific data, tenant configuration, credentials, identifiers, and proprietary implementation details are intentionally excluded.

## What It Demonstrates

- PowerShell automation
- CSV-driven workflow design
- Input validation
- Microsoft Graph integration architecture
- Student usage-location configuration
- Microsoft 365 A3 student licensing workflow
- Group-membership automation
- Structured success / failed / skipped outcomes
- Reporting
- Configuration separation
- Git-based change tracking

## Repository Structure

```text
student-provisioning-pipeline/
├── Invoke-StudentProvisioning.ps1
├── Modules/
│   ├── Validation.psm1
│   ├── Graph.psm1
│   └── Reporting.psm1
├── Config/
│   └── settings.example.psd1
├── Samples/
│   └── students.example.csv
├── docs/
│   └── architecture.md
├── Logs/
└── Reports/
```

## Current Portfolio Mode

The repository currently runs safely with fictional sample data and simulated cloud operations.

The Microsoft Graph module is structured so live Graph authentication and provisioning operations can be added without changing the overall pipeline design.

## Background

The design is based on experience automating a previously manual student account-processing workflow in a production Microsoft 365 environment. The production workflow processed structured student data, applied cloud identity configuration, assigned licensing and group membership, and tracked successful, failed, and skipped outcomes.

## Safety

No production tenant identifiers, credentials, student records, internal domains, group IDs, application IDs, or organization-specific configuration are included.