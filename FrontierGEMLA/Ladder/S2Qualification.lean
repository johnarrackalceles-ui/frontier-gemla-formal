import FrontierGEMLA.Ladder.S2Candidate

/-!
Qualification of a second-order S2 improvement candidate.

Primary sources:
- Dual-Track Addendum v5.3, sections 8 and 9.
- Eqs. AD-23 and AD-24.
- FrontierGEMLA AEL / S3 provisional draft, section A.6.

S2 remains a unified stage. A proposed change to the improvement
process is evaluated using:
1. capability-improvement promotion history;
2. operational-assurance promotion history;
3. constitutional promotion history;
4. the proposed successor improvement process;
5. the converged self-invariant used in the proposal.

This module defines qualification of that candidate only. It does not
yet define independent protected verification, persistent admission,
recovery, or consequential authority.
-/

namespace FrontierGEMLA

/--
A second-order candidate is qualified when each separated promotion-
history component, the proposed successor improver, and the converged
self-invariant satisfy their declared qualification predicates.
-/
def S2PromotionQualified
    {improver capHist opsHist constHist selfInv : Type}
    (capHistoryOK : capHist → Prop)
    (opsHistoryOK : opsHist → Prop)
    (constHistoryOK : constHist → Prop)
    (candidateImproverOK : improver → Prop)
    (selfInvariantOK : selfInv → Prop)
    (candidate :
      S2Candidate improver capHist opsHist constHist selfInv) :
    Prop :=
  capHistoryOK candidate.promotionHistory.capabilityHistory ∧
  opsHistoryOK candidate.promotionHistory.operationalHistory ∧
  constHistoryOK candidate.promotionHistory.constitutionalHistory ∧
  candidateImproverOK candidate.candidateImprover ∧
  selfInvariantOK candidate.selfInvariant

/--
S2 qualification requires the capability-improvement history term.
-/
theorem s2PromotionQualified_requires_capability_history
    {improver capHist opsHist constHist selfInv : Type}
    (capHistoryOK : capHist → Prop)
    (opsHistoryOK : opsHist → Prop)
    (constHistoryOK : constHist → Prop)
    (candidateImproverOK : improver → Prop)
    (selfInvariantOK : selfInv → Prop)
    (candidate :
      S2Candidate improver capHist opsHist constHist selfInv)
    (h : S2PromotionQualified
      capHistoryOK opsHistoryOK constHistoryOK
      candidateImproverOK selfInvariantOK candidate) :
    capHistoryOK candidate.promotionHistory.capabilityHistory := by
  exact h.1

/--
S2 qualification requires the operational-assurance history term.
-/
theorem s2PromotionQualified_requires_operational_history
    {improver capHist opsHist constHist selfInv : Type}
    (capHistoryOK : capHist → Prop)
    (opsHistoryOK : opsHist → Prop)
    (constHistoryOK : constHist → Prop)
    (candidateImproverOK : improver → Prop)
    (selfInvariantOK : selfInv → Prop)
    (candidate :
      S2Candidate improver capHist opsHist constHist selfInv)
    (h : S2PromotionQualified
      capHistoryOK opsHistoryOK constHistoryOK
      candidateImproverOK selfInvariantOK candidate) :
    opsHistoryOK candidate.promotionHistory.operationalHistory := by
  exact h.2.1

/--
S2 qualification requires the constitutional promotion-history term.
-/
theorem s2PromotionQualified_requires_constitutional_history
    {improver capHist opsHist constHist selfInv : Type}
    (capHistoryOK : capHist → Prop)
    (opsHistoryOK : opsHist → Prop)
    (constHistoryOK : constHist → Prop)
    (candidateImproverOK : improver → Prop)
    (selfInvariantOK : selfInv → Prop)
    (candidate :
      S2Candidate improver capHist opsHist constHist selfInv)
    (h : S2PromotionQualified
      capHistoryOK opsHistoryOK constHistoryOK
      candidateImproverOK selfInvariantOK candidate) :
    constHistoryOK candidate.promotionHistory.constitutionalHistory := by
  exact h.2.2.1

/--
S2 qualification requires the proposed successor improvement process to
satisfy its declared second-order improvement predicate.
-/
theorem s2PromotionQualified_requires_candidate_improver
    {improver capHist opsHist constHist selfInv : Type}
    (capHistoryOK : capHist → Prop)
    (opsHistoryOK : opsHist → Prop)
    (constHistoryOK : constHist → Prop)
    (candidateImproverOK : improver → Prop)
    (selfInvariantOK : selfInv → Prop)
    (candidate :
      S2Candidate improver capHist opsHist constHist selfInv)
    (h : S2PromotionQualified
      capHistoryOK opsHistoryOK constHistoryOK
      candidateImproverOK selfInvariantOK candidate) :
    candidateImproverOK candidate.candidateImprover := by
  exact h.2.2.2.1

/--
S2 qualification requires the converged self-invariant term used by the
second-order proposal to satisfy its declared predicate.
-/
theorem s2PromotionQualified_requires_self_invariant
    {improver capHist opsHist constHist selfInv : Type}
    (capHistoryOK : capHist → Prop)
    (opsHistoryOK : opsHist → Prop)
    (constHistoryOK : constHist → Prop)
    (candidateImproverOK : improver → Prop)
    (selfInvariantOK : selfInv → Prop)
    (candidate :
      S2Candidate improver capHist opsHist constHist selfInv)
    (h : S2PromotionQualified
      capHistoryOK opsHistoryOK constHistoryOK
      candidateImproverOK selfInvariantOK candidate) :
    selfInvariantOK candidate.selfInvariant := by
  exact h.2.2.2.2

/--
All five declared S2 qualification terms are sufficient to establish
qualification of the second-order candidate.
-/
theorem s2PromotionQualified_of_requirements
    {improver capHist opsHist constHist selfInv : Type}
    (capHistoryOK : capHist → Prop)
    (opsHistoryOK : opsHist → Prop)
    (constHistoryOK : constHist → Prop)
    (candidateImproverOK : improver → Prop)
    (selfInvariantOK : selfInv → Prop)
    (candidate :
      S2Candidate improver capHist opsHist constHist selfInv)
    (hCap :
      capHistoryOK candidate.promotionHistory.capabilityHistory)
    (hOps :
      opsHistoryOK candidate.promotionHistory.operationalHistory)
    (hConst :
      constHistoryOK candidate.promotionHistory.constitutionalHistory)
    (hImprover :
      candidateImproverOK candidate.candidateImprover)
    (hSelf :
      selfInvariantOK candidate.selfInvariant) :
    S2PromotionQualified
      capHistoryOK opsHistoryOK constHistoryOK
      candidateImproverOK selfInvariantOK candidate := by
  exact ⟨hCap, hOps, hConst, hImprover, hSelf⟩

/--
Existence of a second-order candidate does not itself establish S2
qualification. Its evidence and successor-improver predicates remain
independent judgments.
-/
theorem s2Candidate_does_not_self_qualify
    {improver capHist opsHist constHist selfInv : Type}
    (candidate :
      S2Candidate improver capHist opsHist constHist selfInv) :
    ¬ S2PromotionQualified
      (fun _ => False)
      (fun _ => True)
      (fun _ => True)
      (fun _ => True)
      (fun _ => True)
      candidate := by
  intro h
  exact
    s2PromotionQualified_requires_capability_history
      (fun _ => False)
      (fun _ => True)
      (fun _ => True)
      (fun _ => True)
      (fun _ => True)
      candidate
      h

end FrontierGEMLA
