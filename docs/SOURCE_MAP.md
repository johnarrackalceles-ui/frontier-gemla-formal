# FrontierGEMLA Formal Source Map

## Status of this map

This document records manual correspondence between Lean declarations
and the governing FrontierGEMLA project texts.

The correspondence itself is not machine-checked by Lean. Lean checks
the formal definitions and deductions after those definitions have been
declared.

## Frozen spike source basis

The original `G3A_S1_ladder_rules.lean` spike cites:

- Dual-Track Addendum v5.3, sections 7, 7.1, 7.2 and 10
- Context section 22, decision items 2 through 6
- Scope revision 17, section 1.8 and D4

The modular library preserves the formal content of that spike while
moving declarations into permanent modules.

## Declaration map

| Lean declaration | Module | Source correspondence | Status |
| --- | --- | --- | --- |
| `Track` | `Shared/Types.lean` | Dual-track development ladder | Manual source correspondence |
| `Stage` | `Shared/Types.lean` | G2-C2 dual-track ladder | Manual source correspondence |
| `Node` | `Shared/Types.lean` | Track-qualified stage notation | Formalization helper |
| `Det` | `Shared/Types.lean` | Scope revision 17 section 1.8 and D4 | Manual source correspondence |
| `Outcome` | `Shared/Types.lean` | Addendum section 7.2 | Manual source correspondence |
| `ConditionalResult` | `Ladder/Conditional.lean` | Context section 22 item 4 | Manual source correspondence |
| `ConditionalResult.buildOn` | `Ladder/Conditional.lean` | Context section 22 item 4 | Manual source correspondence |
| `ConditionalResult.label_inherited` | `Ladder/Conditional.lean` | Context section 22 item 4 | Proven from formal definition |
| `EnterS1` | `Ladder/S1.lean` | Addendum v5.3 Eq. AD-17 | Manual source correspondence |
| `enterS1_ignores_G2_G3` | `Ladder/S1.lean` | Addendum section 7.2 open-predecessor rule | Proven from formal definition |
| `AcceptS1` | `Ladder/S1.lean` | Addendum v5.3 Eq. AD-16 | Manual source correspondence |
| `acceptS1_needs_ops` | `Ladder/S1.lean` | S1 conjunction / claim-discipline requirement | Proven from formal definition |
| `S1Terms` | `Ladder/S1.lean` | AD-16 terms plus three-valued determination | Formalization structure |
| `Reads` | `Ladder/S1.lean` | Addendum section 7.2 outcome wording | Manual source correspondence |
| `hold_and_reject_overlap` | `Ladder/S1.lean` | Context section 22 item 6 unresolved mapping | Proven ambiguity; policy unresolved |
| `reject_and_recover_overlap` | `Ladder/S1.lean` | Addendum section 7.2 unresolved precedence | Proven ambiguity; policy unresolved |
| `GenerationId` | `Shared/Identity.lean` | Shared generation identity requirement | Typed vocabulary only |
| `ConstitutionRef` | `Shared/Identity.lean` | Shared constitution requirement | Typed vocabulary only |

## Important current limitation

`GenerationId` and `ConstitutionRef` have been introduced as typed
formal vocabulary, but `EnterS1` currently still represents
`sharedGeneration` and `sharedConstitution` as propositions.

Therefore the repository does not yet formalize the concrete relation
by which two track states are shown to share a generation identity or
constitutional reference.

That refinement is a later formalization obligation.

## Claim discipline

The repository distinguishes three layers:

1. Lean certifies the formal specification and deductions from it.
2. Conformance evidence connects an implementation to that specification.
3. Empirical evidence establishes premises that are not formal consequences.

A successful Lean proof does not by itself establish implementation
conformance, empirical validity, or fidelity of the prose-to-formal
translation.