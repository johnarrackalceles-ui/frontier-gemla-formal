import FrontierGEMLA.Ladder.Jq
import FrontierGEMLA.Ladder.S1Identity

/-!
C2 compatibility verification for S1 convergence.

Primary source:
- Dual-Track Addendum v5.3, sections 6, 7 and 7.1.
- Eq. AD-12: Jq pass does not imply equality of track evidence states.
- Eq. AD-17: J_C2 is a distinct S1 entry term.

The addendum distinguishes the availability record made at a track
boundary from the verification, concluding at S1, that Track A and
Track B remain joinable under the shared constitutional substrate.

This module preserves the existing `Jq` relation. A C2 boundary record
stores the states and compatibility terms to be checked; `Jc2Verified`
states that the recorded pair satisfies `Jq`.
-/

namespace FrontierGEMLA

universe u v

/--
The Track A and Track B states, together with the compatibility terms,
recorded at the C2 boundary.

The existence of this record does not itself assert that J_C2 passes.
-/
structure C2AvailabilityRecord (α : Type u) (β : Type v) where
  trackAState : α
  trackBState : β
  terms       : JqTerms

/--
J_C2 verification: the two states recorded at the C2 boundary satisfy
the existing Jq compatibility relation.

This is deliberately separate from merely possessing a boundary record.
-/
def Jc2Verified
    {α : Type u} {β : Type v}
    (joinable : α → β → Prop)
    (record : C2AvailabilityRecord α β) : Prop :=
  Jq joinable
    record.trackAState
    record.trackBState
    record.terms

/--
J_C2 is exactly Jq applied to the states and terms stored in the C2
availability record.
-/
theorem jc2Verified_bridge
    {α : Type u} {β : Type v}
    (joinable : α → β → Prop)
    (record : C2AvailabilityRecord α β) :
    Jc2Verified joinable record ↔
      Jq joinable
        record.trackAState
        record.trackBState
        record.terms := by
  rfl

/-- A verified J_C2 condition requires the recorded states to be joinable. -/
theorem jc2Verified_requires_joinable
    {α : Type u} {β : Type v}
    (joinable : α → β → Prop)
    (record : C2AvailabilityRecord α β)
    (h : Jc2Verified joinable record) :
    joinable record.trackAState record.trackBState := by
  unfold Jc2Verified at h
  exact jq_requires_joinable
    joinable
    record.trackAState
    record.trackBState
    record.terms
    h

/--
S1 entry with the abstract J_C2 proposition instantiated by verification
of the recorded C2 compatibility state.
-/
def EnterS1Converged
    {α : Type u} {β : Type v}
    {γ κ : Type}
    (p : Stage → Track → Prop)
    (joinable : α → β → Prop)
    (record : C2AvailabilityRecord α β)
    (ids : S1IdentityState γ κ) : Prop :=
  EnterS1Typed p (Jc2Verified joinable record) ids

/--
The converged entry predicate is exactly the typed S1 predicate with
J_C2 instantiated by the C2 verification proposition.
-/
theorem enterS1Converged_bridge
    {α : Type u} {β : Type v}
    {γ κ : Type}
    (p : Stage → Track → Prop)
    (joinable : α → β → Prop)
    (record : C2AvailabilityRecord α β)
    (ids : S1IdentityState γ κ) :
    EnterS1Converged p joinable record ids ↔
      EnterS1Typed p (Jc2Verified joinable record) ids := by
  rfl

/-- Converged S1 entry requires J_C2 verification. -/
theorem enterS1Converged_requires_jc2
    {α : Type u} {β : Type v}
    {γ κ : Type}
    (p : Stage → Track → Prop)
    (joinable : α → β → Prop)
    (record : C2AvailabilityRecord α β)
    (ids : S1IdentityState γ κ)
    (h : EnterS1Converged p joinable record ids) :
    Jc2Verified joinable record := by
  unfold EnterS1Converged EnterS1Typed EnterS1 at h
  exact h.2.2.2.2.2.2.1

/--
Consequently, entry through the converged S1 predicate requires the
recorded Track A and Track B states themselves to satisfy joinability.
-/
theorem enterS1Converged_requires_joinable
    {α : Type u} {β : Type v}
    {γ κ : Type}
    (p : Stage → Track → Prop)
    (joinable : α → β → Prop)
    (record : C2AvailabilityRecord α β)
    (ids : S1IdentityState γ κ)
    (h : EnterS1Converged p joinable record ids) :
    joinable record.trackAState record.trackBState := by
  apply jc2Verified_requires_joinable joinable record
  exact enterS1Converged_requires_jc2 p joinable record ids h

end FrontierGEMLA