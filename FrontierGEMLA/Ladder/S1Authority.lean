import FrontierGEMLA.Ladder.S1Admission

/-!
Typed consequential-authority record for an admitted S1 successor.

Primary sources:
- Dual-Track Addendum v5.3, section 8.
- FrontierGEMLA AEL / S3 provisional draft, section A.6.

Persistent admission and consequential authority are separate operations.
A valid admitted successor does not automatically receive permission to
exercise its capabilities against consequential targets.

This module therefore places authority downstream of a valid S1
admission record and binds the grant to the exact activated generation.
-/

namespace FrontierGEMLA

/--
Typed record of a consequential-authority grant associated with an
admitted S1 successor.
-/
structure S1AuthorityRecord
    (γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
      activationEv authorityEv : Type) where
  admission :
    S1AdmissionRecord
      γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
      activationEv
  authorityGeneration : GenerationId γ
  authorityEvidence   : authorityEv

/--
An S1 authority record is valid only when:
1. the underlying successor admission is valid;
2. the separate authority evidence satisfies the declared authority
   predicate;
3. the authority grant names exactly the generation that was activated.
-/
def S1AuthorityRecordValid
    {γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
      activationEv authorityEv : Type}
    (capOK : capEv → Prop)
    (opsOK : opsEv → Prop)
    (constOK : constEv → Prop)
    (verifierOK : verifierEv → Prop)
    (activationOK : activationEv → Prop)
    (authorityOK : authorityEv → Prop)
    (record :
      S1AuthorityRecord
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
        activationEv authorityEv) :
    Prop :=
  S1AdmissionRecordValid
      capOK opsOK constOK verifierOK activationOK record.admission ∧
  authorityOK record.authorityEvidence ∧
  record.authorityGeneration =
    record.admission.activatedGeneration

/--
A valid authority record requires a valid persistent admission.
-/
theorem s1AuthorityRecordValid_requires_admission
    {γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
      activationEv authorityEv : Type}
    (capOK : capEv → Prop)
    (opsOK : opsEv → Prop)
    (constOK : constEv → Prop)
    (verifierOK : verifierEv → Prop)
    (activationOK : activationEv → Prop)
    (authorityOK : authorityEv → Prop)
    (record :
      S1AuthorityRecord
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
        activationEv authorityEv)
    (h : S1AuthorityRecordValid
      capOK opsOK constOK verifierOK activationOK authorityOK record) :
    S1AdmissionRecordValid
      capOK opsOK constOK verifierOK activationOK record.admission := by
  exact h.1

/--
A valid authority record requires the separate authority check to pass.
-/
theorem s1AuthorityRecordValid_requires_authority
    {γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
      activationEv authorityEv : Type}
    (capOK : capEv → Prop)
    (opsOK : opsEv → Prop)
    (constOK : constEv → Prop)
    (verifierOK : verifierEv → Prop)
    (activationOK : activationEv → Prop)
    (authorityOK : authorityEv → Prop)
    (record :
      S1AuthorityRecord
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
        activationEv authorityEv)
    (h : S1AuthorityRecordValid
      capOK opsOK constOK verifierOK activationOK authorityOK record) :
    authorityOK record.authorityEvidence := by
  exact h.2.1

/--
A valid authority grant must name exactly the generation that was
persistently activated.
-/
theorem s1AuthorityRecordValid_requires_generation_identity
    {γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
      activationEv authorityEv : Type}
    (capOK : capEv → Prop)
    (opsOK : opsEv → Prop)
    (constOK : constEv → Prop)
    (verifierOK : verifierEv → Prop)
    (activationOK : activationEv → Prop)
    (authorityOK : authorityEv → Prop)
    (record :
      S1AuthorityRecord
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
        activationEv authorityEv)
    (h : S1AuthorityRecordValid
      capOK opsOK constOK verifierOK activationOK authorityOK record) :
    record.authorityGeneration =
      record.admission.activatedGeneration := by
  exact h.2.2

/--
A valid authority record inherits the protected-promotion qualification
of its admitted successor.
-/
theorem s1AuthorityRecordValid_requires_qualified_packet
    {γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
      activationEv authorityEv : Type}
    (capOK : capEv → Prop)
    (opsOK : opsEv → Prop)
    (constOK : constEv → Prop)
    (verifierOK : verifierEv → Prop)
    (activationOK : activationEv → Prop)
    (authorityOK : authorityEv → Prop)
    (record :
      S1AuthorityRecord
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
        activationEv authorityEv)
    (h : S1AuthorityRecordValid
      capOK opsOK constOK verifierOK activationOK authorityOK record) :
    S1PromotionPacketQualified
      capOK opsOK constOK verifierOK record.admission.packet := by
  exact
    s1AdmissionRecordValid_requires_qualified_packet
      capOK opsOK constOK verifierOK activationOK
      record.admission
      (s1AuthorityRecordValid_requires_admission
        capOK opsOK constOK verifierOK activationOK authorityOK
        record h)

/--
A valid authority record therefore also inherits the original AD-16
S1 acceptance requirement.
-/
theorem s1AuthorityRecordValid_requires_acceptance
    {γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
      activationEv authorityEv : Type}
    (capOK : capEv → Prop)
    (opsOK : opsEv → Prop)
    (constOK : constEv → Prop)
    (verifierOK : verifierEv → Prop)
    (activationOK : activationEv → Prop)
    (authorityOK : authorityEv → Prop)
    (record :
      S1AuthorityRecord
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
        activationEv authorityEv)
    (h : S1AuthorityRecordValid
      capOK opsOK constOK verifierOK activationOK authorityOK record) :
    AcceptS1
      (capOK record.admission.packet.capabilityEvidence)
      (opsOK record.admission.packet.operationalEvidence)
      (constOK record.admission.packet.constitutionalEvidence) := by
  exact
    s1AdmissionRecordValid_requires_acceptance
      capOK opsOK constOK verifierOK activationOK
      record.admission
      (s1AuthorityRecordValid_requires_admission
        capOK opsOK constOK verifierOK activationOK authorityOK
        record h)

/--
A valid admission, a successful independent authority check, and exact
generation identity are sufficient to validate the authority record.
-/
theorem s1AuthorityRecordValid_of_requirements
    {γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
      activationEv authorityEv : Type}
    (capOK : capEv → Prop)
    (opsOK : opsEv → Prop)
    (constOK : constEv → Prop)
    (verifierOK : verifierEv → Prop)
    (activationOK : activationEv → Prop)
    (authorityOK : authorityEv → Prop)
    (record :
      S1AuthorityRecord
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
        activationEv authorityEv)
    (hAdmission :
      S1AdmissionRecordValid
        capOK opsOK constOK verifierOK activationOK record.admission)
    (hAuthority : authorityOK record.authorityEvidence)
    (hIdentity :
      record.authorityGeneration =
        record.admission.activatedGeneration) :
    S1AuthorityRecordValid
      capOK opsOK constOK verifierOK activationOK authorityOK record := by
  exact ⟨hAdmission, hAuthority, hIdentity⟩

/--
A structurally present authority record cannot become valid when the
separate authority check fails, even if admission succeeded.
-/
theorem s1AuthorityRecord_fails_without_authority
    {γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
      activationEv authorityEv : Type}
    (capOK : capEv → Prop)
    (opsOK : opsEv → Prop)
    (constOK : constEv → Prop)
    (verifierOK : verifierEv → Prop)
    (activationOK : activationEv → Prop)
    (authorityOK : authorityEv → Prop)
    (record :
      S1AuthorityRecord
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
        activationEv authorityEv)
    (hFail : ¬ authorityOK record.authorityEvidence) :
    ¬ S1AuthorityRecordValid
      capOK opsOK constOK verifierOK activationOK authorityOK record := by
  intro h
  exact hFail
    (s1AuthorityRecordValid_requires_authority
      capOK opsOK constOK verifierOK activationOK authorityOK record h)

end FrontierGEMLA
