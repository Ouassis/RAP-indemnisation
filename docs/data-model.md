# Proposed data model

This is a logical model, not an activated DDIC or CDS definition. Confirm field names, domains, key strategy, and audit requirements in the target SAP system.

## Request root

| Field concept | Purpose | Notes |
|---|---|---|
| Request ID | Stable technical/business identifier | Prefer a UUID or approved number-range strategy |
| Requester | Person who submits the request | Resolve identity from the authenticated context where appropriate |
| Created At / By | Creation audit | Populate consistently in the backend |
| Changed At / By | Change audit | Update on relevant modifications |
| Amount | Requested amount | Use a currency-aware amount type |
| Currency | Currency key | Validate against supported currency configuration |
| Request Date | Business date | Define timezone/date semantics |
| Reason | Explanation for the request | Apply length and content rules |
| Status | Current lifecycle state | Change only through controlled actions |
| Reviewer | Assigned or acting reviewer | Apply authorization and privacy rules |
| Decision At / By | Decision audit | Set on approval/rejection |
| Decision Reason | Explanation of decision | Required when policy specifies |
| Payment Reference | Finance/payment reference | Populate only from a trusted source |
| Paid At | Confirmed payment timestamp/date | Define authoritative source |

## Relationships

Keep the initial model small. Add child entities only where there is a clear requirement, such as multiple expense lines or document references. Avoid storing duplicate financial facts if an authoritative SAP business object already owns them.

## Validation rules to consider

- Amount must be greater than zero and fit the applicable currency precision.
- Currency must be present and supported.
- Required business fields must be supplied before submission.
- Rejection requires a reason if policy requires one.
- Only eligible statuses may transition to the requested target status.
- A request must not be marked paid without a valid payment confirmation source.
- Updates to immutable audit fields must be rejected or ignored safely.

## Persistence and concurrency

Choose keys and table design based on the target release and expected volume. Use RAP's supported locking and ETag/concurrency mechanisms where appropriate. Test concurrent approval, cancellation, and payment updates so that stale clients cannot silently overwrite decisions.
