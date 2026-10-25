/-!
G3-A / S1 ladder rules: a first Lean 4 target.  [P] DRAFT, for the
user's review.  NOT COMPILED: the reviewer's workspace could not reach a
Lean toolchain [U].  No Mathlib is used; core Lean 4 only.

Sources (project documents, read by the reviewer):
  Addendum v5.3, sections 7, 7.1, 7.2, 10 (Eq. AD-16 and AD-17).
  Context, section 22, decision items 2 to 6.
  Scope revision 17, 1.8 and D4 (determination values).

Where the text leaves a choice open, this file states the open choice as
a theorem about the text's own wording.  It does not make the choice.

Not in this file: Theorems 7.1 and 15.1, T1 to T10, anything about the
F1 to F5 records, and the Python code of g3a_filament/.
-/

namespace FrontierGEMLA

/-- The two evidence tracks (Addendum 1). -/
inductive Track where
  | A | B
  deriving DecidableEq, Repr

/-- Stages inside a track, G2 to C2 (Addendum 3.2). -/
inductive Stage where
  | G2 | G3 | G4 | C1 | C2
  deriving DecidableEq, Repr

/-- A node of the ladder, for example G3-A is `(Stage.G3, Track.A)`. -/
abbrev Node := Stage × Track

/-! ### S1 entry (Eq. AD-17) -/

/-- Eq. AD-17.  `p s t` says that the stage term of stage `s` on track
`t` holds.  G2 and G3 are not terms of it (Addendum 7.2). -/
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

/-! ### Conditional label (Context 22, item 4) -/

/-- A result and its label: the open predecessors the label names. -/
structure ConditionalResult where
  node   : Node
  labels : List Node

/-- A result built on `r` at node `n` while the predecessors `now` are
open: the label names every open predecessor and is inherited by later
results built on it (Context 22, item 4). -/
def ConditionalResult.buildOn
    (r : ConditionalResult) (n : Node) (now : List Node) :
    ConditionalResult :=
  { node := n, labels := r.labels ++ now }

/-- A label is never dropped by building on the result. -/
theorem ConditionalResult.label_inherited
    (r : ConditionalResult) (n : Node) (now : List Node) (x : Node)
    (hx : x ∈ r.labels) : x ∈ (r.buildOn n now).labels := by
  unfold ConditionalResult.buildOn
  exact List.mem_append_left now hx

/-! ### Determinations and S1 outcomes (scope 1.8; Addendum 7.2) -/

/-- Determination values.  Three values, not a Bool: an UNKNOWN is not a
NO (scope 1.8). -/
inductive Det where
  | no | unknown | yes
  deriving DecidableEq, Repr

/-- The three terms of Eq. AD-16, each with a determination on the
available evidence. -/
structure S1Terms where
  cap   : Det
  ops   : Det
  const : Det

/-- Outcomes of an S1 evaluation: acceptance, or the return to shadow
evaluation as HOLD, REJECT or RECOVER (Addendum 7.2). -/
inductive Outcome where
  | accept | hold | reject | recover
  deriving DecidableEq, Repr

/-- The wording of Addendum 7.2, read as a relation and nothing more:
HOLD when a term cannot yet be decided; REJECT when a term fails;
RECOVER for a store, ledger or run anomaly (`anomaly`).  Acceptance is
Eq. AD-16 with every term YES.  No precedence between the outcomes is
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

/-- OPEN CHOICE 1.  The wording does not make the outcome a function of
the evidence: one term NO and another UNKNOWN reads as both HOLD and
REJECT.  Context 22, item 6 calls the mapping "proposed" and says the
original manuscript's definitions govern if they differ. -/
theorem hold_and_reject_overlap :
    ∃ t : S1Terms, Reads false t .hold ∧ Reads false t .reject :=
  ⟨⟨.no, .unknown, .yes⟩,
   .hold (Or.inr (Or.inl rfl)),
   .reject (Or.inl rfl)⟩

/-- OPEN CHOICE 2.  The wording gives no precedence between an anomaly
and a failed term: one term NO with an anomaly reads as both REJECT and
RECOVER. -/
theorem reject_and_recover_overlap :
    ∃ t : S1Terms, Reads true t .reject ∧ Reads true t .recover :=
  ⟨⟨.no, .yes, .yes⟩,
   .reject (Or.inl rfl),
   .recover rfl⟩

end FrontierGEMLA
