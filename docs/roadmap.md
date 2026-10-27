# Product roadmap

## Phase 1 — Requirements and baseline

- Confirm target SAP release, deployment model, and supported ABAP language version.
- Agree on the request lifecycle, roles, amount/currency rules, and payment source.
- Define the smallest viable data model and API contract.
- Record architecture decisions and acceptance criteria.

**Exit criteria:** business rules and release assumptions are documented and reviewed.

## Phase 2 — Core RAP business object

- Implement persistence and CDS view entities.
- Add behavior, validations, determinations, and controlled actions.
- Add authorization checks and audit handling.
- Write ABAP Unit tests for core business rules.

**Exit criteria:** core behavior is tested in a compatible development system.

## Phase 3 — Service and Fiori experience

- Publish the service using a supported binding.
- Configure Fiori elements list/object pages and metadata annotations.
- Add useful filters, status presentation, and action feedback.
- Verify service access and authorization outside the UI.

**Exit criteria:** primary user journeys work end to end in a test environment.

## Phase 4 — Integration and operations

- Define any finance/payment integration contract.
- Add idempotency and safe retry behavior where asynchronous or remote events are involved.
- Add monitoring, support diagnostics, and actionable error handling.
- Document deployment, configuration, and rollback.

**Exit criteria:** operational risks and failure recovery have been tested.

## Phase 5 — Product hardening

- Run ATC and regression suites.
- Validate performance and realistic data volumes.
- Review privacy, security, accessibility, and documentation.
- Prepare a demo using synthetic data only.

**Exit criteria:** release candidate reviewed and its supported SAP compatibility stated clearly.

## Current status

This repository currently documents the proposed product foundation. Implementation, activation, and compatibility remain unverified until artifacts are built and tested in a target SAP system.
