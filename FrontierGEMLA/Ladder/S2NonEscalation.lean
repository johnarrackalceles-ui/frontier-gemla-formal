import FrontierGEMLA.Ladder.S2Admission

/-!
S2 non-self-escalation boundary.

Primary sources:
- Dual-Track Addendum v5.3, section 9.
- FrontierGEMLA AEL / S3 provisional draft, section A.6.

A second-order improvement may change the process that generates,
searches for, ranks, or tests candidate improvements.

Admission of that improved process does not by itself grant permission
to rewrite or control the protected verifier, authority issuer, signing
keys, semantic constitution, or recovery mechanism.

This module represents self-granted protected control separately from
any externally authorized constitutional change.
-/

namespace FrontierGEMLA

/--
Protected-control permissions that the candidate improver might attempt
to grant to itself.

These fields represent self-granted control only. They do not model a
separate externally authorized constitutional change.
-/
structure S2SelfGrantState where
  verifierRewrite             : Bool
  authorityIssuerRewrite      : Bool
  signingKeyControl           : Bool
  semanticConstitutionRewrite : Bool
  recoveryMechanismRewrite    : Bool

/--
The S2 non-self-escalation constraint: none of the protected controls
has been self-granted by the admitted improver.
-/
def S2NonSelfEscalating
    (state : S2SelfGrantState) : Prop :=
  state.verifierRewrite = false ∧
  state.authorityIssuerRewrite = false ∧
  state.signingKeyControl = false ∧
  state.semanticConstitutionRewrite = false ∧
  state.recoveryMechanismRewrite = false

/--
An S2 governed admission pairs the ordinary persistent admission record
with an explicit state describing attempted self-grants over protected
governance components.
-/
structure S2GovernedAdmission
    (improver capHist opsHist constHist selfInv
      verifierEv recoveryEv activationEv : Type) where
  admission :
    S2AdmissionRecord
      improver capHist opsHist constHist selfInv
      verifierEv recoveryEv activationEv
  selfGrants : S2SelfGrantState

/--
A governed S2 admission is valid only when:
1. the underlying S2 persistent admission is valid; and
2. the admitted improver remains non-self-escalating.
-/
def S2GovernedAdmissionValid
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
        verifierEv recoveryEv activationEv) :
    Prop :=
  S2AdmissionRecordValid
      capHistoryOK
      opsHistoryOK
      constHistoryOK
      candidateImproverOK
      selfInvariantOK
      verifierOK
      recoveryOK
      activationOK
      record.admission ∧
  S2NonSelfEscalating record.selfGrants

/--
A valid governed S2 admission requires a valid persistent admission.
-/
theorem s2GovernedAdmissionValid_requires_admission
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
  exact h.1

/--
A valid governed S2 admission requires the non-self-escalation
constraint.
-/
theorem s2GovernedAdmissionValid_requires_non_self_escalation
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
    S2NonSelfEscalating record.selfGrants := by
  exact h.2

/--
Valid S2 governance forbids a self-granted verifier rewrite.
-/
theorem s2GovernedAdmissionValid_forbids_verifier_self_grant
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
    record.selfGrants.verifierRewrite = false := by
  exact h.2.1

/--
Valid S2 governance forbids a self-granted authority-issuer rewrite.
-/
theorem s2GovernedAdmissionValid_forbids_authority_issuer_self_grant
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
    record.selfGrants.authorityIssuerRewrite = false := by
  exact h.2.2.1

/--
Valid S2 governance forbids self-granted signing-key control.
-/
theorem s2GovernedAdmissionValid_forbids_signing_key_self_grant
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
    record.selfGrants.signingKeyControl = false := by
  exact h.2.2.2.1

/--
Valid S2 governance forbids a self-granted semantic-constitution
rewrite.
-/
theorem s2GovernedAdmissionValid_forbids_semantic_constitution_self_grant
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
    record.selfGrants.semanticConstitutionRewrite = false := by
  exact h.2.2.2.2.1

/--
Valid S2 governance forbids a self-granted recovery-mechanism rewrite.
-/
theorem s2GovernedAdmissionValid_forbids_recovery_self_grant
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
    record.selfGrants.recoveryMechanismRewrite = false := by
  exact h.2.2.2.2.2

/--
A valid S2 admission together with the non-self-escalation constraint is
sufficient for a valid governed admission.
-/
theorem s2GovernedAdmissionValid_of_requirements
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
    (hAdmission :
      S2AdmissionRecordValid
        capHistoryOK opsHistoryOK constHistoryOK
        candidateImproverOK selfInvariantOK
        verifierOK recoveryOK activationOK
        record.admission)
    (hNonSelf :
      S2NonSelfEscalating record.selfGrants) :
    S2GovernedAdmissionValid
      capHistoryOK opsHistoryOK constHistoryOK
      candidateImproverOK selfInvariantOK
      verifierOK recoveryOK activationOK record := by
  exact ⟨hAdmission, hNonSelf⟩

/--
Persistent S2 admission can remain fully non-self-escalating.

This witnesses that admission of the improved improver does not require
or generate any of the protected self-grants.
-/
theorem s2Admission_can_remain_non_self_escalating
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
      S2GovernedAdmissionValid
        capHistoryOK opsHistoryOK constHistoryOK
        candidateImproverOK selfInvariantOK
        verifierOK recoveryOK activationOK governed := by
  let grants : S2SelfGrantState :=
    {
      verifierRewrite := false
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
  refine ⟨governed, rfl, ?_⟩
  exact ⟨hAdmission, ⟨rfl, rfl, rfl, rfl, rfl⟩⟩

end FrontierGEMLA
