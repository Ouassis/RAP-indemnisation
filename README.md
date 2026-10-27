# RAP Indemnisation

A product-oriented SAP application blueprint for managing indemnisation requests using ABAP RESTful Application Programming Model (RAP), CDS, OData, and SAP Fiori elements.

**Status:** Initial foundation / design baseline  
**Product owner:** Abdessamad ELGAROUATE  
**Repository:** https://github.com/Ouassis/RAP-indemnisation

## Product vision

RAP Indemnisation aims to provide a clear, auditable workflow for creating, reviewing, approving, and tracking indemnisation requests in SAP. The design emphasizes maintainability, authorization-aware access, traceability, and a modern Fiori user experience.

This repository is a standalone product foundation. It must not contain customer-specific code, confidential business data, credentials, or proprietary material from an employer or client.

## Intended capabilities

- Create and maintain indemnisation requests.
- Capture the requester, amount, currency, dates, reason, and supporting business references.
- Apply a configurable status lifecycle and controlled state transitions.
- Support review and approval steps with authorization checks.
- Provide searchable lists, object details, and status-focused worklists through Fiori elements.
- Record important business changes for traceability.
- Expose a documented OData service contract.
- Include automated test scenarios and deployment guidance.

The initial implementation should keep business rules in the RAP business object behavior layer and avoid embedding client-specific assumptions.

## Proposed technology baseline

- ABAP RESTful Application Programming Model (RAP)
- Core Data Services (CDS) view entities
- OData V4 where supported by the target SAP release
- SAP Fiori elements
- ABAP Unit for business logic tests
- ATC checks and transport-based deployment

**Compatibility note:** RAP, OData V4, draft handling, authorization features, and Fiori capabilities vary by SAP release and deployment model. Confirm the target system's release and installed components before implementation.

## Repository map

- `docs/architecture.md` — logical architecture and request lifecycle
- `docs/data-model.md` — proposed domain model and field semantics
- `docs/security.md` — authorization, privacy, and audit principles
- `docs/testing.md` — test strategy and acceptance scenarios
- `docs/roadmap.md` — staged delivery plan
- `src/abap/` — location for release-compatible ABAP artifacts
- `test/` — test cases and supporting fixtures

## Design principles

1. **Clean Core:** prefer released APIs and extension points; avoid modifying SAP standard objects.
2. **Explicit business rules:** validate amounts, required fields, and status transitions in the behavior implementation.
3. **Least privilege:** enforce access on the server, not only in the UI.
4. **Traceability:** retain the identity and timestamps needed to understand important decisions.
5. **Testability:** isolate business rules and cover both successful and rejected transitions.
6. **Portability:** document release dependencies and avoid customer-specific identifiers.

## Development workflow

1. Confirm the target SAP product, release, deployment model, and ABAP language version.
2. Review the domain model and state machine before generating repository-specific artifacts.
3. Implement CDS entities, behavior definitions/implementations, service definition/binding, and UI annotations in a development system.
4. Run syntax checks, ATC, ABAP Unit, authorization tests, and end-to-end tests.
5. Document transport and rollback steps before deployment.

ABAP artifacts in this repository are design and development assets, not a claim that code has been activated or validated in an SAP system. All code must be reviewed and tested in a compatible non-production SAP environment.

## Product ownership and licensing

This repository is maintained as an independent product project by Abdessamad ELGAROUATE. No open-source license has been selected yet. Until a license is added, do not assume that third parties have permission to redistribute or commercially reuse the contents.

## Contributing

Keep contributions generic and product-focused. Do not submit customer names, customer data, internal tickets, credentials, production endpoints, or code copied from proprietary systems. Document assumptions and add tests for changes to business behavior.
