import FrontierGEMLA.Ladder.S1PromotionPacket

/-!
Typed persistent-admission record for an S1 successor.

Primary sources:
- Dual-Track Addendum v5.3, section 8.
- Eqs. AD-19--AD-22.
- FrontierGEMLA AEL / S3 provisional draft, section A.6.

A qualified promotion packet is not itself an activated persistent
successor. Admission additionally requires activation evidence and a
binding showing that the activated generation is the candidate identified
by the qualified packet.

Consequential authority is intentionally absent from this record and
remains a separate operation.
-/

namespace FrontierGEMLA

/--
Typed record of an attempted S1 successor admission.

The record carries the promotion packet, the generation that was
activated, and typed evidence of that activation.
-/
structure S1AdmissionRecord
    (γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
      activationEv : Type) where
  packet :
    S1PromotionPacket
      γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
  activatedGeneration : GenerationId γ
  activationEvidence  : activationEv

/--
An admission record is valid only when:
1. its promotion packet is qualified;
2. its activation evidence satisfies the declared activation predicate;
3. the activated generation is exactly the candidate generation named
   by the promotion packet.
-/
def S1AdmissionRecordValid
    {γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
      activationEv : Type}
    (capOK : capEv → Prop)
    (opsOK : opsEv → Prop)
    (constOK : constEv → Prop)
    (verifierOK : verifierEv → Prop)
    (activationOK : activationEv → Prop)
    (record :
      S1AdmissionRecord
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
        activationEv) :
    Prop :=
  S1PromotionPacketQualified
      capOK opsOK constOK verifierOK record.packet ∧
  activationOK record.activationEvidence ∧
  record.activatedGeneration = record.packet.candidateGeneration

/--
A valid admission record requires a qualified promotion packet.
-/
theorem s1AdmissionRecordValid_requires_qualified_packet
    {γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
      activationEv : Type}
    (capOK : capEv → Prop)
    (opsOK : opsEv → Prop)
    (constOK : constEv → Prop)
    (verifierOK : verifierEv → Prop)
    (activationOK : activationEv → Prop)
    (record :
      S1AdmissionRecord
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
        activationEv)
    (h : S1AdmissionRecordValid
      capOK opsOK constOK verifierOK activationOK record) :
    S1PromotionPacketQualified
      capOK opsOK constOK verifierOK record.packet := by
  exact h.1

/--
A valid admission record requires successful activation evidence.
-/
theorem s1AdmissionRecordValid_requires_activation
    {γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
      activationEv : Type}
    (capOK : capEv → Prop)
    (opsOK : opsEv → Prop)
    (constOK : constEv → Prop)
    (verifierOK : verifierEv → Prop)
    (activationOK : activationEv → Prop)
    (record :
      S1AdmissionRecord
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
        activationEv)
    (h : S1AdmissionRecordValid
      capOK opsOK constOK verifierOK activationOK record) :
    activationOK record.activationEvidence := by
  exact h.2.1

/--
A valid admission record binds the activated generation to the candidate
generation named by the qualified promotion packet.
-/
theorem s1AdmissionRecordValid_requires_candidate_identity
    {γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
      activationEv : Type}
    (capOK : capEv → Prop)
    (opsOK : opsEv → Prop)
    (constOK : constEv → Prop)
    (verifierOK : verifierEv → Prop)
    (activationOK : activationEv → Prop)
    (record :
      S1AdmissionRecord
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
        activationEv)
    (h : S1AdmissionRecordValid
      capOK opsOK constOK verifierOK activationOK record) :
    record.activatedGeneration = record.packet.candidateGeneration := by
  exact h.2.2

/--
A valid admitted successor inherits the AD-16 acceptance requirement
from its qualified promotion packet.
-/
theorem s1AdmissionRecordValid_requires_acceptance
    {γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
      activationEv : Type}
    (capOK : capEv → Prop)
    (opsOK : opsEv → Prop)
    (constOK : constEv → Prop)
    (verifierOK : verifierEv → Prop)
    (activationOK : activationEv → Prop)
    (record :
      S1AdmissionRecord
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
        activationEv)
    (h : S1AdmissionRecordValid
      capOK opsOK constOK verifierOK activationOK record) :
    AcceptS1
      (capOK record.packet.capabilityEvidence)
      (opsOK record.packet.operationalEvidence)
      (constOK record.packet.constitutionalEvidence) := by
  exact
    s1PromotionPacketQualified_requires_acceptance
      capOK opsOK constOK verifierOK record.packet
      (s1AdmissionRecordValid_requires_qualified_packet
        capOK opsOK constOK verifierOK activationOK record h)

/--
A valid admitted successor inherits the independent-verifier
requirement from its qualified promotion packet.
-/
theorem s1AdmissionRecordValid_requires_verifier
    {γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
      activationEv : Type}
    (capOK : capEv → Prop)
    (opsOK : opsEv → Prop)
    (constOK : constEv → Prop)
    (verifierOK : verifierEv → Prop)
    (activationOK : activationEv → Prop)
    (record :
      S1AdmissionRecord
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
        activationEv)
    (h : S1AdmissionRecordValid
      capOK opsOK constOK verifierOK activationOK record) :
    verifierOK record.packet.verifierEvidence := by
  exact
    s1PromotionPacketQualified_requires_verifier
      capOK opsOK constOK verifierOK record.packet
      (s1AdmissionRecordValid_requires_qualified_packet
        capOK opsOK constOK verifierOK activationOK record h)

/--
A qualified packet, successful activation evidence, and exact generation
identity are sufficient to validate the admission record.
-/
theorem s1AdmissionRecordValid_of_requirements
    {γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
      activationEv : Type}
    (capOK : capEv → Prop)
    (opsOK : opsEv → Prop)
    (constOK : constEv → Prop)
    (verifierOK : verifierEv → Prop)
    (activationOK : activationEv → Prop)
    (record :
      S1AdmissionRecord
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
        activationEv)
    (hPacket :
      S1PromotionPacketQualified
        capOK opsOK constOK verifierOK record.packet)
    (hActivation : activationOK record.activationEvidence)
    (hIdentity :
      record.activatedGeneration = record.packet.candidateGeneration) :
    S1AdmissionRecordValid
      capOK opsOK constOK verifierOK activationOK record := by
  exact ⟨hPacket, hActivation, hIdentity⟩

/--
Even a structurally present admission record cannot validate when its
declared activation check fails.
-/
theorem s1AdmissionRecord_fails_without_activation
    {γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
      activationEv : Type}
    (capOK : capEv → Prop)
    (opsOK : opsEv → Prop)
    (constOK : constEv → Prop)
    (verifierOK : verifierEv → Prop)
    (activationOK : activationEv → Prop)
    (record :
      S1AdmissionRecord
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
        activationEv)
    (hFail : ¬ activationOK record.activationEvidence) :
    ¬ S1AdmissionRecordValid
      capOK opsOK constOK verifierOK activationOK record := by
  intro h
  exact hFail
    (s1AdmissionRecordValid_requires_activation
      capOK opsOK constOK verifierOK activationOK record h)

end FrontierGEMLA
