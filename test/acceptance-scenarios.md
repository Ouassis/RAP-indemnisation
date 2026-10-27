# Acceptance tests — RAP Indemnisation

Run these scenarios in a non-production SAP system after the RAP objects are activated. These are executable test requirements, not a claim that the current code has passed SAP runtime tests.

## Request creation and validation

| ID | Given | When | Expected |
|---|---|---|---|
| VAL-01 | All mandatory fields supplied and amount > 0 | Create request | Request is accepted and starts in DRAFT |
| VAL-02 | Amount is zero | Save request | Save fails with a business error |
| VAL-03 | Amount is negative | Save request | Save fails with a business error |
| VAL-04 | Requester is missing | Save request | Save fails with a business error |
| VAL-05 | Currency is missing | Save request | Save fails with a business error |
| VAL-06 | Reason is missing | Save request | Save fails with a business error |

## One-approver workflow

| ID | Given | When | Expected |
|---|---|---|---|
| WF-01 | Request is DRAFT | Submit | Status becomes SUBMITTED |
| WF-02 | Request is already SUBMITTED | Submit again | Action is rejected |
| WF-03 | Request is SUBMITTED | Authorized reviewer approves | Status becomes APPROVED |
| WF-04 | Request is DRAFT | Approve | Action is rejected |
| WF-05 | Request is SUBMITTED and decision reason is supplied | Authorized reviewer rejects | Status becomes REJECTED |
| WF-06 | Request is SUBMITTED and decision reason is empty | Reject | Action is rejected |
| WF-07 | Request is APPROVED | Approve again | Action is rejected |

## Security and data integrity

- Direct updates to Status are rejected.
- Requesters cannot approve or reject requests unless explicitly authorized by policy.
- Reviewer actions are checked server-side, not only by hiding UI actions.
- Audit fields cannot be set or overwritten by the client.
- Direct OData calls are tested in addition to the Fiori UI.
- Duplicate payment confirmations do not produce duplicate business effects when payment integration is added.

## Execution evidence

For each test run record:
- SAP product/release and ABAP language version.
- Object activation and ATC results.
- Test data identifier using synthetic data only.
- Expected and actual results.
- Defects and follow-up commit.
