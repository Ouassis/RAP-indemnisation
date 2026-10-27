# ABAP source layout

Place reviewed, release-compatible ABAP artifacts here as they are implemented and exported from the target SAP development system.

Suggested organization:
- `cds/` — CDS data and projection view entities
- `behavior/` — behavior definitions and implementation notes
- `service/` — service definitions and bindings
- `metadata/` — metadata extensions and UI annotations

Do not treat this suggested folder structure as an SAP transport/import mechanism. Use the team's approved ABAP development and transport workflow.

Before adding code, confirm the target SAP release, ABAP language version, managed/unmanaged behavior choice, draft requirements, and naming conventions. All artifacts must be syntax-checked, activated, ATC-checked, and tested in a compatible non-production system.
