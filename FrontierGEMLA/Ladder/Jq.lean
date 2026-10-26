import FrontierGEMLA.Shared.Types
import FrontierGEMLA.Shared.Identity

namespace FrontierGEMLA

universe u v

/--
Minimum compatibility obligations for a Jq checkpoint.

These correspond to the seven compatibility dimensions required by
the dual-track addendum. They are propositions because this layer
specifies what must hold, not the runtime mechanism that proves it.
-/
structure JqTerms where
  semanticMeanings      : Prop
  identityNamespaces    : Prop
  evidenceHashSemantics : Prop
  reconstructionRules   : Prop
  protectedBoundaries   : Prop
  promotionSemantics    : Prop
  selfObservationSchema : Prop

/--
Jq checks whether Track A state `a` and Track B state `b` remain
joinable while all required shared-substrate compatibility obligations
hold.

Joinability is intentionally a relation, not equality.
-/
def Jq
    {α : Type u} {β : Type v}
    (joinable : α → β → Prop)
    (a : α) (b : β)
    (t : JqTerms) : Prop :=
  joinable a b ∧
  t.semanticMeanings ∧
  t.identityNamespaces ∧
  t.evidenceHashSemantics ∧
  t.reconstructionRules ∧
  t.protectedBoundaries ∧
  t.promotionSemantics ∧
  t.selfObservationSchema

/--
AD-5 permits distinct Track A and Track B evidence states to pass Jq.
This witness demonstrates that Jq does not itself impose evidence-state
equality.
-/
theorem jq_pass_allows_distinct_evidence_states :
    ∃ a b : Bool,
      a ≠ b ∧
      Jq (fun _ _ => True) a b
        {
          semanticMeanings      := True
          identityNamespaces    := True
          evidenceHashSemantics := True
          reconstructionRules   := True
          protectedBoundaries   := True
          promotionSemantics    := True
          selfObservationSchema := True
        } := by
  refine ⟨true, false, by decide, ?_⟩
  unfold Jq
  exact ⟨True.intro, True.intro, True.intro, True.intro,
         True.intro, True.intro, True.intro, True.intro⟩

end FrontierGEMLA

namespace FrontierGEMLA

/--
A passing Jq checkpoint requires the two track states to satisfy the
declared joinability relation.
-/
theorem jq_requires_joinable
    {α : Type u} {β : Type v}
    (joinable : α → β → Prop)
    (a : α) (b : β) (t : JqTerms)
    (h : Jq joinable a b t) :
    joinable a b :=
  h.1

/--
A passing Jq checkpoint requires consistency of semantic-registry and
event meanings.
-/
theorem jq_requires_semantic_meanings
    {α : Type u} {β : Type v}
    (joinable : α → β → Prop)
    (a : α) (b : β) (t : JqTerms)
    (h : Jq joinable a b t) :
    t.semanticMeanings :=
  h.2.1

/--
A passing Jq checkpoint requires consistency of the relevant identity
namespaces.
-/
theorem jq_requires_identity_namespaces
    {α : Type u} {β : Type v}
    (joinable : α → β → Prop)
    (a : α) (b : β) (t : JqTerms)
    (h : Jq joinable a b t) :
    t.identityNamespaces :=
  h.2.2.1

/--
A passing Jq checkpoint requires consistency of evidence-reference and
canonical-hash semantics.
-/
theorem jq_requires_evidence_hash_semantics
    {α : Type u} {β : Type v}
    (joinable : α → β → Prop)
    (a : α) (b : β) (t : JqTerms)
    (h : Jq joinable a b t) :
    t.evidenceHashSemantics :=
  h.2.2.2.1

/--
A passing Jq checkpoint requires consistency of trajectory/AEL
versioning and historical reconstruction rules.
-/
theorem jq_requires_reconstruction_rules
    {α : Type u} {β : Type v}
    (joinable : α → β → Prop)
    (a : α) (b : β) (t : JqTerms)
    (h : Jq joinable a b t) :
    t.reconstructionRules :=
  h.2.2.2.2.1

/--
A passing Jq checkpoint requires preservation of the protected audit,
authority, and recovery boundaries.
-/
theorem jq_requires_protected_boundaries
    {α : Type u} {β : Type v}
    (joinable : α → β → Prop)
    (a : α) (b : β) (t : JqTerms)
    (h : Jq joinable a b t) :
    t.protectedBoundaries :=
  h.2.2.2.2.2.1

/--
A passing Jq checkpoint requires consistency of promotion and
persistent-change semantics.
-/
theorem jq_requires_promotion_semantics
    {α : Type u} {β : Type v}
    (joinable : α → β → Prop)
    (a : α) (b : β) (t : JqTerms)
    (h : Jq joinable a b t) :
    t.promotionSemantics :=
  h.2.2.2.2.2.2.1

/--
A passing Jq checkpoint requires consistency of the self-observation
schema elements needed for later S1 convergence.
-/
theorem jq_requires_self_observation_schema
    {α : Type u} {β : Type v}
    (joinable : α → β → Prop)
    (a : α) (b : β) (t : JqTerms)
    (h : Jq joinable a b t) :
    t.selfObservationSchema :=
  h.2.2.2.2.2.2.2

end FrontierGEMLA

namespace FrontierGEMLA

theorem jq_fails_if_not_joinable
    {α : Type u} {β : Type v}
    (joinable : α → β → Prop)
    (a : α) (b : β) (t : JqTerms)
    (hFail : ¬ joinable a b) :
    ¬ Jq joinable a b t := by
  intro h
  exact hFail (jq_requires_joinable joinable a b t h)

theorem jq_fails_if_semantic_meanings_fail
    {α : Type u} {β : Type v}
    (joinable : α → β → Prop)
    (a : α) (b : β) (t : JqTerms)
    (hFail : ¬ t.semanticMeanings) :
    ¬ Jq joinable a b t := by
  intro h
  exact hFail (jq_requires_semantic_meanings joinable a b t h)

theorem jq_fails_if_identity_namespaces_fail
    {α : Type u} {β : Type v}
    (joinable : α → β → Prop)
    (a : α) (b : β) (t : JqTerms)
    (hFail : ¬ t.identityNamespaces) :
    ¬ Jq joinable a b t := by
  intro h
  exact hFail (jq_requires_identity_namespaces joinable a b t h)

theorem jq_fails_if_evidence_hash_semantics_fail
    {α : Type u} {β : Type v}
    (joinable : α → β → Prop)
    (a : α) (b : β) (t : JqTerms)
    (hFail : ¬ t.evidenceHashSemantics) :
    ¬ Jq joinable a b t := by
  intro h
  exact hFail (jq_requires_evidence_hash_semantics joinable a b t h)

theorem jq_fails_if_reconstruction_rules_fail
    {α : Type u} {β : Type v}
    (joinable : α → β → Prop)
    (a : α) (b : β) (t : JqTerms)
    (hFail : ¬ t.reconstructionRules) :
    ¬ Jq joinable a b t := by
  intro h
  exact hFail (jq_requires_reconstruction_rules joinable a b t h)

theorem jq_fails_if_protected_boundaries_fail
    {α : Type u} {β : Type v}
    (joinable : α → β → Prop)
    (a : α) (b : β) (t : JqTerms)
    (hFail : ¬ t.protectedBoundaries) :
    ¬ Jq joinable a b t := by
  intro h
  exact hFail (jq_requires_protected_boundaries joinable a b t h)

theorem jq_fails_if_promotion_semantics_fail
    {α : Type u} {β : Type v}
    (joinable : α → β → Prop)
    (a : α) (b : β) (t : JqTerms)
    (hFail : ¬ t.promotionSemantics) :
    ¬ Jq joinable a b t := by
  intro h
  exact hFail (jq_requires_promotion_semantics joinable a b t h)

theorem jq_fails_if_self_observation_schema_fail
    {α : Type u} {β : Type v}
    (joinable : α → β → Prop)
    (a : α) (b : β) (t : JqTerms)
    (hFail : ¬ t.selfObservationSchema) :
    ¬ Jq joinable a b t := by
  intro h
  exact hFail (jq_requires_self_observation_schema joinable a b t h)

end FrontierGEMLA