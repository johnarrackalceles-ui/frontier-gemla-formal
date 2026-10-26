import FrontierGEMLA.Ladder.S2Qualification

/-!
Protected verification and persistent admission for S2.

Primary sources:
- Dual-Track Addendum v5.3, sections 8 and 9.
- FrontierGEMLA AEL / S3 provisional draft, section A.6.

A second-order candidate changes the process that generates, searches
for, ranks, or tests candidate improvements. Qualification of that
candidate does not itself make the new improver persistent.

Persistent S2 admission additionally requires:
1. independent protected verification;
2. recovery preservation;
3. explicit activation evidence.

This module does not grant consequential authority and does not permit
the candidate improver to rewrite protected governance components.
-/

namespace FrontierGEMLA

/--
Typed S2 admission record.

It binds the qualified second-order candidate to independent verifier,
recovery, and activation evidence.
-/
structure S2AdmissionRecord
    (improver capHist opsHist constHist selfInv
      verifierEv recoveryEv activationEv : Type) where
  candidate          :
    S2Candidate improver capHist opsHist constHist selfInv
  verifierEvidence   : verifierEv
  recoveryEvidence   : recoveryEv
  activationEvidence : activationEv

/--
A second-order admission record is valid only when:
1. the S2 candidate is promotion-qualified;
2. independent verifier evidence passes;
3. recovery preservation evidence passes;
4. activation evidence passes.
-/
def S2AdmissionRecordValid
    {improver capHist opsHist constHist selfInv
      verifierEv recoveryEv activationEv : Type}
    (capHistoryOK : capHist → Prop)
    (opsHistoryOK : opsHist → Prop)
    (constHistoryOK : constHist → Prop)
    (candidateImproverOK : improver → Prop)
    (selfInvariantOK : selfInv → Prop)
    (verifierOK : verifierEv → Prop)
    (recoveryOK : recoveryEv → Prop)
    (activationOK : activationEv → Prop)
    (record :
      S2AdmissionRecord
        improver capHist opsHist constHist selfInv
        verifierEv recoveryEv activationEv) :
    Prop :=
  S2PromotionQualified
      capHistoryOK
      opsHistoryOK
      constHistoryOK
      candidateImproverOK
      selfInvariantOK
      record.candidate ∧
  verifierOK record.verifierEvidence ∧
  recoveryOK record.recoveryEvidence ∧
  activationOK record.activationEvidence

/--
Valid S2 admission requires prior S2 promotion qualification.
-/
theorem s2AdmissionRecordValid_requires_qualification
    {improver capHist opsHist constHist selfInv
      verifierEv recoveryEv activationEv : Type}
    (capHistoryOK : capHist → Prop)
    (opsHistoryOK : opsHist → Prop)
    (constHistoryOK : constHist → Prop)
    (candidateImproverOK : improver → Prop)
    (selfInvariantOK : selfInv → Prop)
    (verifierOK : verifierEv → Prop)
    (recoveryOK : recoveryEv → Prop)
    (activationOK : activationEv → Prop)
    (record :
      S2AdmissionRecord
        improver capHist opsHist constHist selfInv
        verifierEv recoveryEv activationEv)
    (h :
      S2AdmissionRecordValid
        capHistoryOK opsHistoryOK constHistoryOK
        candidateImproverOK selfInvariantOK
        verifierOK recoveryOK activationOK record) :
    S2PromotionQualified
      capHistoryOK opsHistoryOK constHistoryOK
      candidateImproverOK selfInvariantOK
      record.candidate := by
  exact h.1

/--
Valid S2 admission requires the independent verifier to pass.
-/
theorem s2AdmissionRecordValid_requires_verifier
    {improver capHist opsHist constHist selfInv
      verifierEv recoveryEv activationEv : Type}
    (capHistoryOK : capHist → Prop)
    (opsHistoryOK : opsHist → Prop)
    (constHistoryOK : constHist → Prop)
    (candidateImproverOK : improver → Prop)
    (selfInvariantOK : selfInv → Prop)
    (verifierOK : verifierEv → Prop)
    (recoveryOK : recoveryEv → Prop)
    (activationOK : activationEv → Prop)
    (record :
      S2AdmissionRecord
        improver capHist opsHist constHist selfInv
        verifierEv recoveryEv activationEv)
    (h :
      S2AdmissionRecordValid
        capHistoryOK opsHistoryOK constHistoryOK
        candidateImproverOK selfInvariantOK
        verifierOK recoveryOK activationOK record) :
    verifierOK record.verifierEvidence := by
  exact h.2.1

/--
Valid S2 admission requires recovery preservation.
-/
theorem s2AdmissionRecordValid_requires_recovery
    {improver capHist opsHist constHist selfInv
      verifierEv recoveryEv activationEv : Type}
    (capHistoryOK : capHist → Prop)
    (opsHistoryOK : opsHist → Prop)
    (constHistoryOK : constHist → Prop)
    (candidateImproverOK : improver → Prop)
    (selfInvariantOK : selfInv → Prop)
    (verifierOK : verifierEv → Prop)
    (recoveryOK : recoveryEv → Prop)
    (activationOK : activationEv → Prop)
    (record :
      S2AdmissionRecord
        improver capHist opsHist constHist selfInv
        verifierEv recoveryEv activationEv)
    (h :
      S2AdmissionRecordValid
        capHistoryOK opsHistoryOK constHistoryOK
        candidateImproverOK selfInvariantOK
        verifierOK recoveryOK activationOK record) :
    recoveryOK record.recoveryEvidence := by
  exact h.2.2.1

/--
Valid S2 admission requires successful activation evidence.
-/
theorem s2AdmissionRecordValid_requires_activation
    {improver capHist opsHist constHist selfInv
      verifierEv recoveryEv activationEv : Type}
    (capHistoryOK : capHist → Prop)
    (opsHistoryOK : opsHist → Prop)
    (constHistoryOK : constHist → Prop)
    (candidateImproverOK : improver → Prop)
    (selfInvariantOK : selfInv → Prop)
    (verifierOK : verifierEv → Prop)
    (recoveryOK : recoveryEv → Prop)
    (activationOK : activationEv → Prop)
    (record :
      S2AdmissionRecord
        improver capHist opsHist constHist selfInv
        verifierEv recoveryEv activationEv)
    (h :
      S2AdmissionRecordValid
        capHistoryOK opsHistoryOK constHistoryOK
        candidateImproverOK selfInvariantOK
        verifierOK recoveryOK activationOK record) :
    activationOK record.activationEvidence := by
  exact h.2.2.2

/--
Qualification, protected verification, recovery preservation, and
activation evidence are sufficient for S2 admission.
-/
theorem s2AdmissionRecordValid_of_requirements
    {improver capHist opsHist constHist selfInv
      verifierEv recoveryEv activationEv : Type}
    (capHistoryOK : capHist → Prop)
    (opsHistoryOK : opsHist → Prop)
    (constHistoryOK : constHist → Prop)
    (candidateImproverOK : improver → Prop)
    (selfInvariantOK : selfInv → Prop)
    (verifierOK : verifierEv → Prop)
    (recoveryOK : recoveryEv → Prop)
    (activationOK : activationEv → Prop)
    (record :
      S2AdmissionRecord
        improver capHist opsHist constHist selfInv
        verifierEv recoveryEv activationEv)
    (hQualified :
      S2PromotionQualified
        capHistoryOK opsHistoryOK constHistoryOK
        candidateImproverOK selfInvariantOK
        record.candidate)
    (hVerifier : verifierOK record.verifierEvidence)
    (hRecovery : recoveryOK record.recoveryEvidence)
    (hActivation : activationOK record.activationEvidence) :
    S2AdmissionRecordValid
      capHistoryOK opsHistoryOK constHistoryOK
      candidateImproverOK selfInvariantOK
      verifierOK recoveryOK activationOK record := by
  exact ⟨hQualified, hVerifier, hRecovery, hActivation⟩

/--
S2 qualification alone does not establish persistent admission because
independent protected verification may still fail.
-/
theorem s2Qualification_can_hold_without_admission :
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
    let record :
      S2AdmissionRecord Bool Unit Unit Unit Unit Bool Unit Unit :=
      {
        candidate := candidate
        verifierEvidence := false
        recoveryEvidence := ()
        activationEvidence := ()
      }
    S2PromotionQualified
        (fun _ => True)
        (fun _ => True)
        (fun _ => True)
        (fun _ => True)
        (fun _ => True)
        candidate ∧
    ¬ S2AdmissionRecordValid
        (fun _ => True)
        (fun _ => True)
        (fun _ => True)
        (fun _ => True)
        (fun _ => True)
        (fun v => v = true)
        (fun _ => True)
        (fun _ => True)
        record := by
  dsimp
  constructor
  · exact ⟨trivial, trivial, trivial, trivial, trivial⟩
  · intro h
    exact Bool.noConfusion h.2.1

/--
Failure of recovery preservation prevents S2 persistent admission.
-/
theorem s2AdmissionRecord_fails_without_recovery
    {improver capHist opsHist constHist selfInv
      verifierEv recoveryEv activationEv : Type}
    (capHistoryOK : capHist → Prop)
    (opsHistoryOK : opsHist → Prop)
    (constHistoryOK : constHist → Prop)
    (candidateImproverOK : improver → Prop)
    (selfInvariantOK : selfInv → Prop)
    (verifierOK : verifierEv → Prop)
    (recoveryOK : recoveryEv → Prop)
    (activationOK : activationEv → Prop)
    (record :
      S2AdmissionRecord
        improver capHist opsHist constHist selfInv
        verifierEv recoveryEv activationEv)
    (hFail : ¬ recoveryOK record.recoveryEvidence) :
    ¬ S2AdmissionRecordValid
      capHistoryOK opsHistoryOK constHistoryOK
      candidateImproverOK selfInvariantOK
      verifierOK recoveryOK activationOK record := by
  intro h
  exact hFail
    (s2AdmissionRecordValid_requires_recovery
      capHistoryOK opsHistoryOK constHistoryOK
      candidateImproverOK selfInvariantOK
      verifierOK recoveryOK activationOK
      record h)

end FrontierGEMLA
