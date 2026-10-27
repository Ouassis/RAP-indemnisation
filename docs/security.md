# Security, privacy, and audit

## Authorization

- Enforce authorization in the RAP backend; UI visibility is not an access-control boundary.
- Define roles for requesters, reviewers/approvers, and support administrators only when those roles are required by the product.
- Apply instance-level rules so users can access only requests permitted by the business policy.
- Verify permissions for each state-changing action, including approve, reject, cancel, and payment confirmation.
- Use released authorization APIs and the authorization model supported by the target SAP release.

## Identity and audit

- Derive the acting identity from the authenticated SAP session or a trusted service context.
- Do not accept caller-supplied user IDs as proof of identity.
- Record relevant changes and decisions with timestamps and actor identity.
- Keep logs useful for investigation while avoiding unnecessary personal or financial data.

## Data protection

- Minimize personal data collected and exposed.
- Define retention, deletion, and access policies with the organization responsible for the deployment.
- Never commit real customer or employee records, production extracts, credentials, private keys, tokens, or internal endpoints to this repository.
- Use synthetic fixtures in documentation and tests.

## Integration safety

If the application later integrates with payment or finance services, define authentication, authorization, timeouts, retry behavior, idempotency, and error handling explicitly. A retry must not cause duplicate payment or duplicate business actions.

## Release readiness checklist

- [ ] Positive and negative authorization tests pass.
- [ ] Direct service calls cannot bypass UI restrictions.
- [ ] Audit fields cannot be spoofed by clients.
- [ ] Sensitive data is not exposed in error messages or logs.
- [ ] Secrets are held in approved secure configuration, not source control.
- [ ] Retention and privacy requirements are documented.
