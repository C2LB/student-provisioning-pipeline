# Architecture

```mermaid
flowchart TD
    A[Student CSV] --> B[Validation]
    B -->|Invalid| C[Skipped Result]
    B -->|Valid| D[Provisioning Orchestrator]
    D --> E[Microsoft Graph]
    E --> F[Usage Location]
    E --> G[A3 License]
    E --> H[Student Group]
    C --> I[Reporting]
    F --> I
    G --> I
    H --> I
    I --> J[CSV Results]
```

## Design Goals

- Keep input validation separate from cloud operations.
- Keep environment-specific values outside the main script.
- Never store tenant secrets in source control.
- Return structured success, failure, and skipped results.
- Make the workflow understandable without access to the production environment.