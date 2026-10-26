import FrontierGEMLA.Ladder.S1Authority

/-!
Typed second-order improvement candidate for S2.

Primary sources:
- Dual-Track Addendum v5.3, sections 8 and 9.
- Eqs. AD-23 and AD-24.
- FrontierGEMLA AEL / S3 provisional draft, section A.6.

S2 changes the process that generates, searches for, ranks, or tests
candidate improvements. It remains unified rather than splitting into
Track A and Track B stages.

The source also keeps promotion history separated into capability,
operational, and constitutional components and requires a second-order
candidate to remain non-authoritative until the protected promotion path
succeeds.

This module introduces only the candidate/shadow representation. It does
not yet define S2 promotion qualification or persistent admission.
-/

namespace FrontierGEMLA

/--
Track-qualified and constitutional promotion history used when evaluating
a proposed change to the improvement process.

This corresponds schematically to Eq. AD-23:
H_prom = (H_prom^A, H_prom^B, H_prom^const).
-/
structure S2PromotionHistory
    (capHist opsHist constHist : Type) where
  capabilityHistory     : capHist
  operationalHistory    : opsHist
  constitutionalHistory : constHist

/--
Typed candidate for a second-order improvement.

`currentImprover` represents the presently governed improvement process.
`candidateImprover` represents a proposed successor improvement process.

The promotion-history and converged-self-invariant payloads remain
generic because the source specifies their roles but not one mandatory
concrete representation.
-/
structure S2Candidate
    (improver capHist opsHist constHist selfInv : Type) where
  currentImprover    : improver
  candidateImprover  : improver
  promotionHistory   : S2PromotionHistory capHist opsHist constHist
  selfInvariant      : selfInv

/--
A shadow S2 candidate carries an explicit proof that it has no current
production authority.

This represents the candidate-only boundary before protected promotion.
-/
structure S2ShadowCandidate
    (improver capHist opsHist constHist selfInv : Type)
    (productionAuthority : Prop) where
  candidate :
    S2Candidate improver capHist opsHist constHist selfInv
  noProductionAuthority : ¬ productionAuthority

/--
Retrieve the capability-improvement component of S2 promotion history.
-/
def s2PromotionHistory_capability
    {capHist opsHist constHist : Type}
    (h : S2PromotionHistory capHist opsHist constHist) :
    capHist :=
  h.capabilityHistory

/--
Retrieve the operational-assurance component of S2 promotion history.
-/
def s2PromotionHistory_operational
    {capHist opsHist constHist : Type}
    (h : S2PromotionHistory capHist opsHist constHist) :
    opsHist :=
  h.operationalHistory

/--
Retrieve the constitutional component of S2 promotion history.
-/
def s2PromotionHistory_constitutional
    {capHist opsHist constHist : Type}
    (h : S2PromotionHistory capHist opsHist constHist) :
    constHist :=
  h.constitutionalHistory

/--
A shadow second-order candidate has no production authority under the
declared production-authority proposition.
-/
theorem s2ShadowCandidate_requires_no_production_authority
    {improver capHist opsHist constHist selfInv : Type}
    {productionAuthority : Prop}
    (c :
      S2ShadowCandidate
        improver capHist opsHist constHist selfInv productionAuthority) :
    ¬ productionAuthority := by
  exact c.noProductionAuthority

/--
The candidate improvement process need not be identical to the current
improvement process.

This is a witness of separation between the governed improver and a
proposed second-order successor; it does not assert that every S2
candidate must differ.
-/
theorem s2_candidate_can_propose_distinct_improver :
    ∃ c : S2Candidate Bool Unit Unit Unit Unit,
      c.currentImprover ≠ c.candidateImprover := by
  let history : S2PromotionHistory Unit Unit Unit :=
    {
      capabilityHistory := ()
      operationalHistory := ()
      constitutionalHistory := ()
    }
  let candidate : S2Candidate Bool Unit Unit Unit Unit :=
    {
      currentImprover := false
      candidateImprover := true
      promotionHistory := history
      selfInvariant := ()
    }
  refine ⟨candidate, ?_⟩
  decide

/--
A second-order candidate can exist in shadow space without production
authority.

Candidate generation therefore does not itself create consequential
authority.
-/
theorem s2_candidate_can_exist_without_production_authority :
    ∃ c : S2ShadowCandidate Bool Unit Unit Unit Unit False,
      c.candidate.currentImprover ≠ c.candidate.candidateImprover := by
  let history : S2PromotionHistory Unit Unit Unit :=
    {
      capabilityHistory := ()
      operationalHistory := ()
      constitutionalHistory := ()
    }
  let candidate : S2Candidate Bool Unit Unit Unit Unit :=
    {
      currentImprover := false
      candidateImprover := true
      promotionHistory := history
      selfInvariant := ()
    }
  let shadow : S2ShadowCandidate Bool Unit Unit Unit Unit False :=
    {
      candidate := candidate
      noProductionAuthority := fun h => h
    }
  refine ⟨shadow, ?_⟩
  decide

end FrontierGEMLA
