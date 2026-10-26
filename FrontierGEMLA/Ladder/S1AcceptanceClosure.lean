import FrontierGEMLA.Ladder.S1

/-!
Closure consequences for S1 acceptance.

Primary source:
- Dual-Track Addendum v5.3, section 7.
- Eq. AD-16.

`AcceptS1` is already defined in `S1.lean` as the conjunction of:
1. capability / transfer improvement or required non-regression;
2. platform / operational improvement or required non-regression;
3. constitutional preservation.

This module adds no new S1 policy. It exposes constructive consequences
of the existing definition and completes the fail-closed symmetry of the
three acceptance terms.
-/

namespace FrontierGEMLA

/--
S1 acceptance requires the capability / transfer term.
-/
theorem acceptS1_requires_capability
    (pCap pOps pConst : Prop)
    (h : AcceptS1 pCap pOps pConst) :
    pCap := by
  unfold AcceptS1 at h
  exact h.1

/--
S1 acceptance requires the platform / operational term.
-/
theorem acceptS1_requires_operations
    (pCap pOps pConst : Prop)
    (h : AcceptS1 pCap pOps pConst) :
    pOps := by
  unfold AcceptS1 at h
  exact h.2.1

/--
S1 acceptance requires constitutional preservation.
-/
theorem acceptS1_requires_constitution
    (pCap pOps pConst : Prop)
    (h : AcceptS1 pCap pOps pConst) :
    pConst := by
  unfold AcceptS1 at h
  exact h.2.2

/--
The three required S1 terms are sufficient to construct the existing
AD-16 acceptance proposition.
-/
theorem acceptS1_of_required_terms
    (pCap pOps pConst : Prop)
    (hCap : pCap)
    (hOps : pOps)
    (hConst : pConst) :
    AcceptS1 pCap pOps pConst := by
  exact ⟨hCap, hOps, hConst⟩

/--
Failure of the capability / transfer term prevents S1 acceptance.
-/
theorem acceptS1_needs_capability
    (pCap pOps pConst : Prop)
    (h : ¬ pCap) :
    ¬ AcceptS1 pCap pOps pConst := by
  intro hA
  exact h (acceptS1_requires_capability pCap pOps pConst hA)

/--
Failure of constitutional preservation prevents S1 acceptance.
The operational counterpart already exists as `acceptS1_needs_ops`
in `S1.lean`.
-/
theorem acceptS1_needs_constitution
    (pCap pOps pConst : Prop)
    (h : ¬ pConst) :
    ¬ AcceptS1 pCap pOps pConst := by
  intro hA
  exact h (acceptS1_requires_constitution pCap pOps pConst hA)

end FrontierGEMLA
