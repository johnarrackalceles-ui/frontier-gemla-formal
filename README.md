
# FrontierGEMLA Formalization

This repository contains the Lean 4 formalization accompanying the
FrontierGEMLA manuscript and its Dual-Track Implementation and Evidence
Decomposition addendum.

The artifact formalizes the logical dependency structure of the staged
development ladder, protected recursive-improvement boundaries, and the
conditional S3 bounded-superintelligence candidate claim.

## Scope of the formalization

The Lean development machine-checks implications, separations,
fail-closed conditions, typed evidence bindings, and claim boundaries in
the formal model.

It does **not** establish that an empirical implementation has achieved
the capability predicates supplied to the formal gates.

In particular, the artifact does not by itself prove:

- that broadly superhuman cross-domain capability has been empirically
  demonstrated;
- that unfamiliar-domain acquisition or transfer benchmarks have passed;
- that a real system satisfies T1-T10 or R1-R4;
- that universal intelligence or universal safety has been achieved;
- indefinite stability; or
- correctness outside a declared evaluation envelope.

These remain empirical or externally supplied premises where represented
as predicates in the formal model.

## Machine-checked ladder

The principal formal path is:

```text
G2-C2 dual-track evidence
        |
        v
S1 convergence
        |
        v
S1 acceptance
        |
        v
proof-carrying promotion
        |
        v
persistent admission
        |
        v
separate consequential authority

S2 candidate improvement
        |
        v
S2 qualification
        |
        v
protected admission
        |
        v
non-self-escalating governed admission

T1-T10 + R1-R4
        |
        v
S3 readiness
        |
        v
unified S3 claim gate
        |
        v
declared benchmark envelope
        |
        v
bounded S3 candidate claim

Major modules:
Formal layer	                Lean modules
Shared types and identity	Shared/Types.lean, Shared/Identity.lean
Dual-track compatibility	Ladder/Jq.lean, Ladder/Jc2.lean
S1 convergence	                Ladder/S1Identity.lean, Ladder/ConvergenceClosure.lean
S1 acceptance	                Ladder/S1AcceptanceClosure.lean, Ladder/S1Noncollapse.lean
S1 promotion	                Ladder/S1Promotion.lean, Ladder/S1PromotionPacket.lean
S1 admission and authority	Ladder/S1Admission.lean, Ladder/S1Authority.lean
S2 second-order candidate	Ladder/S2Candidate.lean, Ladder/S2Qualification.lean
S2 protected admission	        Ladder/S2Admission.lean
S2 non-self-escalation	        Ladder/S2NonEscalation.lean, Ladder/S2Closure.lean
S3 readiness	                Ladder/S3Readiness.lean
Unified S3 gate	                Ladder/S3ClaimGate.lean
Bounded S3 claim	        Ladder/S3BoundedClaim.lean
Concrete S1/S2 binding	        Ladder/S3RecursiveBinding.lean, Ladder/S3GateBinding.lean
End-to-end closure	        Ladder/S3CrossPhaseClosure.lean
Publication axiom audit	        Ladder/AxiomReport.lean


Reproducing the formal checks
The project is pinned to:
Lean 4.35.0
Lake 5.0.0

The toolchain is declared in lean-toolchain.

From the repository root:
lake build

To print the publication-facing axiom report:
lake env lean FrontierGEMLA/Ladder/AxiomReport.lean

To check for unfinished Lean proofs:
grep -REn --include='*.lean' '\b(sorry|admit)\b' FrontierGEMLA

A successful release is expected to:
1. build without errors;
2. contain no sorry or admit;
3. pass the publication axiom report;
4. preserve isolation of the historical Spike modules; and
5. pass the GitHub Actions workflow in .github/workflows/lean.yml.

## Axiom policy

The publication-facing theorem report is maintained in
`FrontierGEMLA/Ladder/AxiomReport.lean`.

The current modular theorem surface through the Phase 6 cross-phase
closure is axiom-free under Lean's `#print axioms` audit.

One historical parity theorem, `enterS1_ignores_G2_G3`, reports Lean's
standard `propext` axiom. This proof is intentionally retained unchanged
from the historical spike so that the repository can continuously verify
exact spike-to-modular parity. It is not an additional FrontierGEMLA
scientific assumption.

The historical spike parity report is separate from the publication
axiom report.

## Claim interpretation
The formal artifact establishes consequences conditional on the
formal premises supplied to each gate.

For example, the Lean model can prove that an S3 claim cannot pass
without its required cross-domain, readiness, recovery, authority, and
audit conditions. It does not replace experimental evidence establishing
those premises.

The bounded S3 claim is deliberately scoped to a declared benchmark
envelope. The formalization does not entail universal intelligence,
universal safety, indefinite stability, or correctness outside the tested
envelope.

## Historical formal checkpoints
The repository records staged closure tags including:
- phase2-formal-closure
- phase3-formal-closure
- phase4-formal-closure
- phase5-formal-closure
- phase6-formal-closure

For scientific citation, use the dedicated publication release tag and
its exact commit rather than a moving branch such as main.

## Manuscript traceability
The formalization is intended as a machine-checkable companion to:
- the FrontierGEMLA conditional S3 bounded-superintelligence candidate
  manuscript; and
- the Dual-Track Implementation and Evidence Decomposition addendum.

The Lean artifact formalizes the logical claim structure. Experimental
results, benchmark measurements, implementation validation, and other
empirical premises remain separate scientific evidence.