import FrontierGEMLA.Ladder.Jc2
import FrontierGEMLA.Ladder.S1AcceptanceClosure

/-!
Non-collapse between S1 entry and S1 acceptance.

Primary source:
- Dual-Track Addendum v5.3, sections 7 and 7.1.
- Eq. AD-16: acceptance of a proposed first-order change.
- Eq. AD-17: conservative entry into S1 convergence.

`EnterS1Converged` establishes that the dual tracks are ready to
jointly evaluate an S1 successor. `AcceptS1` evaluates the separate
capability, operational, and constitutional terms of a particular
proposed change.

This module adds no promotion or activation semantics.
-/

namespace FrontierGEMLA

universe u v

/--
An S1 convergence-entry proof does not determine acceptance of a
particular successor.

For any established convergence entry, there is an assignment of the
independent AD-16 acceptance terms for which acceptance fails.
-/
theorem enterS1Converged_does_not_determine_acceptance
    {α : Type u} {β : Type v}
    {γ κ : Type}
    (p : Stage → Track → Prop)
    (joinable : α → β → Prop)
    (record : C2AvailabilityRecord α β)
    (ids : S1IdentityState γ κ)
    (hEntry : EnterS1Converged p joinable record ids) :
    ∃ pCap pOps pConst : Prop,
      EnterS1Converged p joinable record ids ∧
      ¬ AcceptS1 pCap pOps pConst := by
  refine ⟨False, True, True, hEntry, ?_⟩
  exact acceptS1_needs_capability False True True (fun h => h)

/--
Conversely, satisfaction of the three AD-16 acceptance terms does not
establish the independent AD-17 convergence-entry obligations.

Here all three acceptance terms hold while every track-qualified stage
predicate is false, so S1 entry fails.
-/
theorem acceptS1_does_not_establish_converged_entry
    {α : Type u} {β : Type v}
    {γ κ : Type}
    (joinable : α → β → Prop)
    (record : C2AvailabilityRecord α β)
    (ids : S1IdentityState γ κ) :
    AcceptS1 True True True ∧
      ¬ EnterS1Converged (fun _ _ => False) joinable record ids := by
  constructor
  · exact acceptS1_of_required_terms True True True trivial trivial trivial
  · intro hEntry
    unfold EnterS1Converged EnterS1Typed EnterS1 at hEntry
    exact hEntry.1

end FrontierGEMLA
