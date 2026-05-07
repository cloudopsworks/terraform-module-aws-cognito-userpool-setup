## Terragrunt Boilerplate Inputs

This repository includes a Terragrunt boilerplate under `.boilerplate/` for consumers that scaffold module usage.

Key allocation rules:

| Concern | Input source | Generated module input |
|---------|--------------|------------------------|
| Organization | `env-inputs.yaml` -> `org` | `org` |
| Spoke | `spoke-inputs.yaml` -> `spoke` | `spoke_def` |
| Tags | `*-tags.json` merged from global/env/region/spoke/local | `extra_tags` |
| Cognito domain | `.boilerplate/inputs.yaml` -> `domain.zone`, `domain.alias`, `domain.certificate`, `domain.certificate_arn` | `domain_zone`, `domain_alias`, `domain_certificate`, `domain_certificate_arn` |
| Cross-account ACM | `.boilerplate/inputs.yaml` -> `cross_account.enabled` or legacy `cross_account_acm` | `cross_account_acm` |
| External ACM dependency | Scaffold-time `acm_enabled` and `acm_path` | `domain_certificate_arn` from `dependency.acm.outputs.acm_certificate_arn` |

Notes:

- Prefer the grouped `domain` object in `.boilerplate/inputs.yaml`; flat `domain_*` keys remain supported for backward compatibility.
- `acm_enabled` and `acm_path` are boilerplate render-time settings, not Terraform module variables.
- When `cross_account.enabled` is false, the generated cross-account provider file is disabled and removed by Terragrunt.
- When `cross_account.enabled` is true, set `cross_account.region` and `cross_account.sts_role_arn` unless your inherited `global-inputs.yaml` provides `default.region` and `default.sts_role_arn`.
