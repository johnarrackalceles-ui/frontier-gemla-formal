# formal-spike-v0.1

## Identity

Tag: `formal-spike-v0.1`
Commit: `6943bbb321fe8b0697f591e026b4335f5e49aea4`
Lean: `4.35.0`
Lean version output:
`Lean (version 4.35.0, x86_64-w64-windows-gnu, commit eb6cafb7290e8bd5f2937522d8d804f58f02bafc, Release)`
Mathlib: none

## Canonical source

File:

`FrontierGEMLA/Spike/G3A_S1_ladder_rules.lean`

Canonical Git-content SHA-256:

`bfe6b483f21dd4ee2865bbbe2dafceeb2a5fb06240ecc8da24cba40f92e2acb0`

## Verification status

At tag creation:
- local Windows build: PASS
- GitHub Actions build: PASS
- historical Spike axiom report: PASS

Subsequent re-verification:
- historical Spike builds explicitly in cache-independent CI: PASS
- modular baseline builds explicitly in cache-independent CI: PASS
- historical/modular axiom-profile parity: PASS
- production axiom audit allowlist: `[propext]`

## Axiom report

`enterS1_ignores_G2_G3`:
`[propext]`

`acceptS1_needs_ops`:
no axioms

`ConditionalResult.label_inherited`:
no axioms

`hold_and_reject_overlap`:
no axioms

`reject_and_recover_overlap`:
no axioms

## Scope

This baseline establishes successful compilation and the reported proof
dependencies of the first S1/ladder formalization target.

It does not establish:

- machine-checked fidelity to the governing prose
- implementation conformance
- empirical validity
- resolution of HOLD/REJECT precedence
- resolution of REJECT/RECOVER precedence