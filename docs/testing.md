# Testing strategy

Test in a non-production SAP system that matches the intended release and configuration. The repository's documents do not prove that any ABAP artifact has been activated or executed.

## Unit tests

Use ABAP Unit for business rules that can be isolated from external dependencies:

- Amount and currency validation.
- Required fields before submission.
- Allowed and rejected status transitions.
- Rejection reason validation.
- Permission-dependent action behavior where the design supports a test seam.
- Mapping of trusted payment confirmation to request state.

## Behavior and service tests

- Create, read, update, and delete behavior according to the intended lifecycle.
- Verify that immutable fields and protected statuses cannot be changed directly.
- Verify action success and error responses.
- Test optimistic concurrency or locking behavior.
- Verify service metadata and entity/action exposure.
- Test filtering, sorting, and paging on realistic synthetic volumes.

## Authorization tests

- Requester can access only permitted requests.
- Reviewer can perform only authorized review actions.
- Unauthorized callers cannot invoke state-changing actions through direct OData requests.
- Administrative access is restricted and audited.

## Acceptance scenarios

1. A valid requester creates a draft and submits it.
2. An incomplete request cannot be submitted.
3. An authorized reviewer approves a submitted request.
4. An unauthorized user cannot approve the request.
5. A rejection without a required reason is refused.
6. A stale client cannot overwrite a newer decision.
7. A request cannot be marked paid without a valid trusted confirmation.
8. A permitted payment confirmation updates the state once, even if the same event is delivered again.

## Quality gates

- ABAP syntax and activation checks.
- ATC checks with the team's agreed variant.
- ABAP Unit tests.
- Service-level tests in the target configuration.
- Manual Fiori usability and accessibility review.
- Transport, rollback, and monitoring procedures reviewed before release.
