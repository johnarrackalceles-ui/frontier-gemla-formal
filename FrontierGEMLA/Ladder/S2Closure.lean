import FrontierGEMLA.Ladder.S2NonEscalation

/-!
Phase 4 closure for unified S2 second-order improvement.

This module introduces no new S2 semantics. It records the outward
consequences of the Phase 4 model and closes the final non-collapse
boundary between persistent admission and governed non-self-escalating
admission.
-/

namespace FrontierGEMLA

/--
A valid governed S2 admission necessarily contains a valid persistent
S2 admission.
-/
theorem s2Closure_governed_requires_admission
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
      S2GovernedAdmission
        improver capHist opsHist constHist selfInv
        verifierEv recoveryEv activationEv)
    (h :
      S2GovernedAdmissionValid
        capHistoryOK opsHistoryOK constHistoryOK
        candidateImproverOK selfInvariantOK
        verifierOK recoveryOK activationOK record) :
    S2AdmissionRecordValid
      capHistoryOK opsHistoryOK constHistoryOK
      candidateImproverOK selfInvariantOK
      verifierOK recoveryOK activationOK
      record.admission := by
  exact
    s2GovernedAdmissionValid_requires_admission
      capHistoryOK opsHistoryOK constHistoryOK
      candidateImproverOK selfInvariantOK
      verifierOK recoveryOK activationOK
      record h

/--
A valid governed S2 admission therefore also requires S2 promotion
qualification of the underlying second-order candidate.
-/
theorem s2Closure_governed_requires_qualification
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
      S2GovernedAdmission
        improver capHist opsHist constHist selfInv
        verifierEv recoveryEv activationEv)
    (h :
      S2GovernedAdmissionValid
        capHistoryOK opsHistoryOK constHistoryOK
        candidateImproverOK selfInvariantOK
        verifierOK recoveryOK activationOK record) :
    S2PromotionQualified
      capHistoryOK opsHistoryOK constHistoryOK
      candidateImproverOK selfInvariantOK
      record.admission.candidate := by
  exact
    s2AdmissionRecordValid_requires_qualification
      capHistoryOK opsHistoryOK constHistoryOK
      candidateImproverOK selfInvariantOK
      verifierOK recoveryOK activationOK
      record.admission
      (s2Closure_governed_requires_admission
        capHistoryOK opsHistoryOK constHistoryOK
        candidateImproverOK selfInvariantOK
        verifierOK recoveryOK activationOK
        record h)

/--
Persistent S2 admission alone does not determine governed admission.

For any valid admission we can construct a governance state around the
same admitted improver that attempts a protected verifier self-grant.
The underlying admission remains valid, but governed validity fails.
-/
theorem s2Admission_does_not_determine_governed_admission
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
    (admission :
      S2AdmissionRecord
        improver capHist opsHist constHist selfInv
        verifierEv recoveryEv activationEv)
    (hAdmission :
      S2AdmissionRecordValid
        capHistoryOK opsHistoryOK constHistoryOK
        candidateImproverOK selfInvariantOK
        verifierOK recoveryOK activationOK admission) :
    ∃ governed :
      S2GovernedAdmission
        improver capHist opsHist constHist selfInv
        verifierEv recoveryEv activationEv,
      governed.admission = admission ∧
      S2AdmissionRecordValid
        capHistoryOK opsHistoryOK constHistoryOK
        candidateImproverOK selfInvariantOK
        verifierOK recoveryOK activationOK
        governed.admission ∧
      ¬ S2GovernedAdmissionValid
        capHistoryOK opsHistoryOK constHistoryOK
        candidateImproverOK selfInvariantOK
        verifierOK recoveryOK activationOK governed := by
  let grants : S2SelfGrantState :=
    {
      verifierRewrite := true
      authorityIssuerRewrite := false
      signingKeyControl := false
      semanticConstitutionRewrite := false
      recoveryMechanismRewrite := false
    }
  let governed :
      S2GovernedAdmission
        improver capHist opsHist constHist selfInv
        verifierEv recoveryEv activationEv :=
    {
      admission := admission
      selfGrants := grants
    }
  refine ⟨governed, rfl, hAdmission, ?_⟩
  intro hGoverned
  have hNoVerifier :
      governed.selfGrants.verifierRewrite = false :=
    s2GovernedAdmissionValid_forbids_verifier_self_grant
      capHistoryOK opsHistoryOK constHistoryOK
      candidateImproverOK selfInvariantOK
      verifierOK recoveryOK activationOK
      governed hGoverned
  exact Bool.noConfusion hNoVerifier

/--
The complete Phase 4 governed path preserves the candidate-only
qualification boundary: governed admission cannot bypass qualification.
-/
theorem s2Closure_governed_cannot_bypass_qualification
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
      S2GovernedAdmission
        improver capHist opsHist constHist selfInv
        verifierEv recoveryEv activationEv)
    (hNotQualified :
      ¬ S2PromotionQualified
        capHistoryOK opsHistoryOK constHistoryOK
        candidateImproverOK selfInvariantOK
        record.admission.candidate) :
    ¬ S2GovernedAdmissionValid
      capHistoryOK opsHistoryOK constHistoryOK
      candidateImproverOK selfInvariantOK
      verifierOK recoveryOK activationOK record := by
  intro hGoverned
  exact hNotQualified
    (s2Closure_governed_requires_qualification
      capHistoryOK opsHistoryOK constHistoryOK
      candidateImproverOK selfInvariantOK
      verifierOK recoveryOK activationOK
      record hGoverned)

end FrontierGEMLA
