import FrontierGEMLA.Ladder.Jc2

/-!
Closure consequences for S1 convergence.

Primary source:
- Dual-Track Addendum v5.3, sections 6, 7 and 7.1.

The source distinguishes:
1. the availability record made at a track boundary;
2. J_C2 verification of joinability under the shared constitutional
   substrate at S1;
3. the separate shared-generation and shared-constitution terms of
   S1 entry.

This module adds no new policy or state. It records consequences of the
existing formal definitions and demonstrates that possession of a C2
availability record alone is not sufficient to establish J_C2.
-/

namespace FrontierGEMLA

universe u v

/--
A C2 availability record can exist even when J_C2 verification fails.

This is a witness of logical separation between recording the boundary
state and proving compatibility. It does not claim that every record
fails verification.
-/
theorem c2_record_can_exist_without_jc2 :
    ∃ record : C2AvailabilityRecord Bool Bool,
      ¬ Jc2Verified (fun _ _ => False) record := by
  let record : C2AvailabilityRecord Bool Bool :=
    {
      trackAState := true
      trackBState := false
      terms :=
        {
          semanticMeanings      := True
          identityNamespaces    := True
          evidenceHashSemantics := True
          reconstructionRules   := True
          protectedBoundaries   := True
          promotionSemantics    := True
          selfObservationSchema := True
        }
    }
  refine ⟨record, ?_⟩
  intro h
  exact jc2Verified_requires_joinable (fun _ _ => False) record h

/--
Converged S1 entry requires the two tracks to identify the same governed
generation.
-/
theorem enterS1Converged_requires_shared_generation
    {α : Type u} {β : Type v}
    {γ κ : Type}
    (p : Stage → Track → Prop)
    (joinable : α → β → Prop)
    (record : C2AvailabilityRecord α β)
    (ids : S1IdentityState γ κ)
    (h : EnterS1Converged p joinable record ids) :
    SharedGeneration ids := by
  unfold EnterS1Converged at h
  exact
    enterS1Typed_requires_shared_generation
      p
      (Jc2Verified joinable record)
      ids
      h

/--
Converged S1 entry requires the two tracks to identify the same
constitutional substrate.
-/
theorem enterS1Converged_requires_shared_constitution
    {α : Type u} {β : Type v}
    {γ κ : Type}
    (p : Stage → Track → Prop)
    (joinable : α → β → Prop)
    (record : C2AvailabilityRecord α β)
    (ids : S1IdentityState γ κ)
    (h : EnterS1Converged p joinable record ids) :
    SharedConstitution ids := by
  unfold EnterS1Converged at h
  exact
    enterS1Typed_requires_shared_constitution
      p
      (Jc2Verified joinable record)
      ids
      h

end FrontierGEMLA
