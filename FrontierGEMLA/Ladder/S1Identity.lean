import FrontierGEMLA.Shared.Identity
import FrontierGEMLA.Ladder.S1

/-!
Typed S1 identity convergence.

Primary source:
- Dual-Track Addendum v5.3, section 7.1, Eq. AD-17.

AD-17 requires S1 entry to include:
- J_C2,
- shared generation identity,
- shared constitution.

This module preserves the existing `EnterS1` definition and supplies a
typed interpretation of its two identity propositions.

Equality of `GenerationId` and `ConstitutionRef` is a formal modeling
choice for "shared" identity/reference. The source does not prescribe
their concrete serialization.
-/

namespace FrontierGEMLA

/--
Track-qualified identity references needed to evaluate the typed
generation and constitution terms of S1 entry.
-/
structure S1IdentityState (γ κ : Type) where
  generationA   : GenerationId γ
  generationB   : GenerationId γ
  constitutionA : ConstitutionRef κ
  constitutionB : ConstitutionRef κ

/-- The two tracks refer to the same governed generation. -/
def SharedGeneration
    {γ κ : Type}
    (ids : S1IdentityState γ κ) : Prop :=
  ids.generationA = ids.generationB

/-- The two tracks refer to the same constitutional substrate. -/
def SharedConstitution
    {γ κ : Type}
    (ids : S1IdentityState γ κ) : Prop :=
  ids.constitutionA = ids.constitutionB

/--
Typed wrapper around the existing AD-17 `EnterS1` definition.

`jC2` remains abstract in this slice. The relationship between boundary
Jq records and the J_C2 condition at S1 is formalized separately.
-/
def EnterS1Typed
    {γ κ : Type}
    (p : Stage → Track → Prop)
    (jC2 : Prop)
    (ids : S1IdentityState γ κ) : Prop :=
  EnterS1 p jC2 (SharedGeneration ids) (SharedConstitution ids)

/--
The typed entry predicate is exactly the existing AD-17 predicate with
its two identity propositions instantiated by the typed relations.
-/
theorem enterS1Typed_bridge
    {γ κ : Type}
    (p : Stage → Track → Prop)
    (jC2 : Prop)
    (ids : S1IdentityState γ κ) :
    EnterS1Typed p jC2 ids ↔
      EnterS1 p jC2 (SharedGeneration ids) (SharedConstitution ids) := by
  rfl

/-- Typed S1 entry requires shared generation identity. -/
theorem enterS1Typed_requires_shared_generation
    {γ κ : Type}
    (p : Stage → Track → Prop)
    (jC2 : Prop)
    (ids : S1IdentityState γ κ)
    (h : EnterS1Typed p jC2 ids) :
    SharedGeneration ids := by
  unfold EnterS1Typed EnterS1 at h
  exact h.2.2.2.2.2.2.2.1

/-- Typed S1 entry requires a shared constitutional reference. -/
theorem enterS1Typed_requires_shared_constitution
    {γ κ : Type}
    (p : Stage → Track → Prop)
    (jC2 : Prop)
    (ids : S1IdentityState γ κ)
    (h : EnterS1Typed p jC2 ids) :
    SharedConstitution ids := by
  unfold EnterS1Typed EnterS1 at h
  exact h.2.2.2.2.2.2.2.2

end FrontierGEMLA