# Architecture

## Logical components

```text
SAP Fiori elements
        |
        | OData service
        v
RAP service definition and binding
        |
        v
RAP business object
  - CDS view entities
  - behavior definition
  - behavior implementation
  - validations and determinations
  - authorization checks
        |
        v
Persistence tables
```

The UI is a client of the service, not the authority for business rules. Validate every relevant input and transition in the backend.

## Proposed request lifecycle

Initial status values are a proposal and should be confirmed with business stakeholders:

- `DRAFT` — being prepared by the requester.
- `SUBMITTED` — submitted for review.
- `IN_REVIEW` — under review by an authorized reviewer.
- `APPROVED` — approved according to policy.
- `REJECTED` — rejected with a recorded reason.
- `PAID` — payment has been confirmed by the relevant process.
- `CANCELLED` — cancelled where policy permits.

Do not allow arbitrary status updates. Expose explicit actions such as Submit, Approve, Reject, Cancel, and Mark Paid, with each action validating the current status, caller authorization, required data, and any required reason.

## Suggested RAP artifact structure

Names below are illustrative; align naming and syntax with the target system's conventions.

- Root CDS view entity for the request.
- Child entity for attachments or itemized details only if the business domain requires them.
- Behavior definition with managed or unmanaged implementation chosen after assessing persistence and integration requirements.
- Behavior pool implementing validations, determinations, actions, and authorization.
- Service definition and service binding.
- Metadata extensions for Fiori elements presentation.
- ABAP Unit tests for isolated business rules.

## Design decisions to resolve

- Is draft handling required for incomplete requests?
- Is approval single-step or multi-step?
- Does payment status come from an SAP finance document or an external interface?
- Which SAP release and deployment model are targeted?
- Are attachments stored in SAP or referenced through an approved document service?

These are product decisions, not assumptions to hard-code prematurely.
