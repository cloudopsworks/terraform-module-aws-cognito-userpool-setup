## Terragrunt Boilerplate Inputs

This repository includes a Terragrunt boilerplate under `.boilerplate/` for consumers that
scaffold repeatable Cognito User Pool deployments. The boilerplate keeps environment-wide
settings in parent files and leaves only module-specific identity settings in the generated
`inputs.yaml`.

### Input allocation

| Concern | Input source | Generated module input |
|---------|--------------|------------------------|
| Organization | `env-inputs.yaml` -> `org` | `org` |
| Hub/spoke mode | Scaffold variables | `is_hub` |
| Spoke | `spoke-inputs.yaml` -> `spoke` | `spoke_def` |
| Tags | `*-tags.json` merged from global/env/region/spoke/local | `extra_tags` |
| User pool naming | `.boilerplate/inputs.yaml` -> `name`, `name_prefix` | `name`, `name_prefix` |
| Cognito domain | `.boilerplate/inputs.yaml` -> `domain.zone`, `domain.alias`, `domain.certificate`, `domain.certificate_arn` | `domain_zone`, `domain_alias`, `domain_certificate`, `domain_certificate_arn` |
| Cross-account ACM | `.boilerplate/inputs.yaml` -> `cross_account.enabled` or legacy `cross_account_acm` | `cross_account_acm` |
| External ACM dependency | Scaffold-time `acm_enabled` and `acm_path` | `domain_certificate_arn` from `dependency.acm.outputs.acm_certificate_arn` |
| Authentication controls | `.boilerplate/inputs.yaml` -> MFA, SMS, password policy, recovery, templates | Cognito user pool arguments |
| OAuth APIs | `.boilerplate/inputs.yaml` -> `resource_servers` | `aws_cognito_resource_server` resources |

### Domain configuration

Prefer the grouped `domain` object in `.boilerplate/inputs.yaml`:

```yaml
domain:
  zone: "auth.example.com"
  alias: "login"
  certificate: true
  certificate_arn: ""
```

The generated Terragrunt file maps this to the flat Terraform variables expected by the
module. Legacy flat keys (`domain_zone`, `domain_alias`, `domain_certificate`, and
`domain_certificate_arn`) remain supported for older deployments, but new scaffolds should
use the grouped form so all domain settings stay together.

A Cognito custom domain is created only when both `domain.zone` and `domain.alias` are
non-empty. If either value is empty, the user pool is still created and no custom domain
resource is planned.

### Certificate sources

Use one certificate source per environment:

| Scenario | Settings |
|----------|----------|
| Use an existing certificate | Set `domain.certificate: true` and `domain.certificate_arn` to the ACM ARN. |
| Let the module ACM helper create/return a certificate | Set `domain.certificate: true` and leave `domain.certificate_arn: ""`. |
| Inject an external Terragrunt ACM dependency | Set scaffold-time `acm_enabled: true` and `acm_path`, then leave `domain.certificate_arn: ""`. |
| No custom certificate | Set `domain.certificate: false`. |

When `acm_enabled` is true, the generated `terragrunt.hcl` renders a dependency named
`acm` and assigns `domain_certificate_arn = dependency.acm.outputs.acm_certificate_arn`.
This setting is a scaffold/rendering concern; it is not a Terraform variable consumed by
the module.

### Cross-account provider generation

When certificate validation or DNS ownership lives in another AWS account, use the grouped
`cross_account` object:

```yaml
cross_account:
  enabled: true
  alias: "cross_account"
  region: "us-east-1"
  sts_role_arn: "arn:aws:iam::111122223333:role/TerragruntDnsValidationRole"
```

The scaffold derives `cross_account_acm` from `cross_account.enabled` and generates a
`provider.l.tf` file with the configured AWS provider alias. If `cross_account.enabled` is
false, Terragrunt disables and removes that generated provider file.

If `region` or `sts_role_arn` are omitted, the template falls back to values from
`global-inputs.yaml` when present. Production deployments should set them explicitly when
using a shared DNS or certificate account.

### Authentication and messaging configuration

The boilerplate exposes Cognito settings that are easy to get wrong in ad-hoc Terragrunt
files:

- Keep `deletion_protection: true` for long-lived user pools.
- Enable `enable_mfa_soft_token` only together with `enable_mfa`.
- Provide `sms_configuration` whenever SMS MFA or SMS verification messages are enabled.
- Use either `sms_verification_message` or `verification_message_template` for verification
  messages unless the AWS provider mode explicitly supports both.
- Treat `schema` changes as lifecycle-sensitive: Cognito custom attributes are difficult or
  impossible to rename after creation.
- Model API scopes in `resource_servers` so applications can request explicit OAuth scopes.

### Migration notes

Existing deployments that use flat domain keys do not need to change immediately. During
normal maintenance, migrate to the grouped layout by moving values as follows:

| Legacy key | Grouped key |
|------------|-------------|
| `domain_zone` | `domain.zone` |
| `domain_alias` | `domain.alias` |
| `domain_certificate` | `domain.certificate` |
| `domain_certificate_arn` | `domain.certificate_arn` |
| `cross_account_acm` | `cross_account.enabled` |

After migration, run `terragrunt plan` and confirm the domain FQDN, certificate ARN source,
and provider aliases are unchanged before applying.
