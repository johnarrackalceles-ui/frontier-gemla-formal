import FrontierGEMLA.Shared.Types

/-!
S1 source correspondence

Primary sources for this module:
- Dual-Track Addendum v5.3, sections 7, 7.1 and 7.2
- Eq. AD-16: S1 acceptance
- Eq. AD-17: conservative S1 entry
- Context section 22, items 2-6
- Scope revision 17, section 1.8 and D4

These references document the manual source correspondence of the
formalization. Lean does not itself verify fidelity to the source text.
-/

namespace FrontierGEMLA

/-! ### S1 entry (Eq. AD-17) -/

/-- Eq. AD-17. `p s t` says that the stage term of stage `s` on track
`t` holds. G2 and G3 are not terms of it (Addendum 7.2). -/
def EnterS1 (p : Stage → Track → Prop)
    (jC2 sharedGeneration sharedConstitution : Prop) : Prop :=
  p .G4 .A ∧ p .G4 .B ∧ p .C1 .A ∧ p .C1 .B ∧ p .C2 .A ∧ p .C2 .B ∧
  jC2 ∧ sharedGeneration ∧ sharedConstitution

/-- An open G2 or G3, on either track, does not change the entry
condition: two assignments that agree from G4 on give equivalent
conditions (Addendum 7.2: "does not block entry"). -/
theorem enterS1_ignores_G2_G3
    (p q : Stage → Track → Prop) (jC2 g c : Prop)
    (h : ∀ s t, s ≠ Stage.G2 → s ≠ Stage.G3 → (p s t ↔ q s t)) :
    EnterS1 p jC2 g c ↔ EnterS1 q jC2 g c := by
  have h4A := h .G4 .A (by decide) (by decide)
  have h4B := h .G4 .B (by decide) (by decide)
  have h1A := h .C1 .A (by decide) (by decide)
  have h1B := h .C1 .B (by decide) (by decide)
  have h2A := h .C2 .A (by decide) (by decide)
  have h2B := h .C2 .B (by decide) (by decide)
  simp only [EnterS1, h4A, h4B, h1A, h1B, h2A, h2B]

/-! ### S1 acceptance (Eq. AD-16) -/

/-- Eq. AD-16: the three terms are conjoined. -/
def AcceptS1 (pCap pOps pConst : Prop) : Prop :=
  pCap ∧ pOps ∧ pConst

/-- No term substitutes for another (Addendum, Claim Discipline: a
Track A result cannot stand in for platform assurance, and conversely).
Shown here for the operational term. -/
theorem acceptS1_needs_ops (pCap pOps pConst : Prop) (h : ¬ pOps) :
    ¬ AcceptS1 pCap pOps pConst := by
  intro hA
  unfold AcceptS1 at hA
  exact h hA.2.1

/-! ### Determinations and S1 outcomes -/

/-- The three terms of Eq. AD-16, each with a determination on the
available evidence. -/
structure S1Terms where
  cap   : Det
  ops   : Det
  const : Det

/-- The wording of Addendum 7.2, read as a relation and nothing more:
HOLD when a term cannot yet be decided; REJECT when a term fails;
RECOVER for a store, ledger or run anomaly (`anomaly`). Acceptance is
Eq. AD-16 with every term YES. No precedence between the outcomes is
assumed, because the text states none. -/
inductive Reads (anomaly : Bool) (t : S1Terms) : Outcome → Prop where
  | accept :
      t.cap = .yes → t.ops = .yes → t.const = .yes →
      Reads anomaly t .accept
  | hold :
      (t.cap = .unknown ∨ t.ops = .unknown ∨ t.const = .unknown) →
      Reads anomaly t .hold
  | reject :
      (t.cap = .no ∨ t.ops = .no ∨ t.const = .no) →
      Reads anomaly t .reject
  | recover :
      anomaly = true → Reads anomaly t .recover

/--
OPEN CHOICE 1.

The wording does not make the outcome a function of the evidence:
one term NO and another UNKNOWN reads as both HOLD and REJECT.

Context section 22, item 6 describes the outcome mapping as proposed
and states that the governing source definitions control if they differ.
This theorem records the unresolved overlap; it does not choose a
precedence rule.
-/
theorem hold_and_reject_overlap :
    ∃ t : S1Terms, Reads false t .hold ∧ Reads false t .reject :=
  ⟨⟨.no, .unknown, .yes⟩,
   .hold (Or.inr (Or.inl rfl)),
   .reject (Or.inl rfl)⟩

/--
OPEN CHOICE 2.

The wording gives no precedence between an anomaly and a failed term:
one term NO with an anomaly reads as both REJECT and RECOVER.

This theorem records the unresolved overlap; it does not choose a
precedence rule.
-/
theorem reject_and_recover_overlap :
    ∃ t : S1Terms, Reads true t .reject ∧ Reads true t .recover :=
  ⟨⟨.no, .yes, .yes⟩,
   .reject (Or.inl rfl),
   .recover rfl⟩

end FrontierGEMLA
