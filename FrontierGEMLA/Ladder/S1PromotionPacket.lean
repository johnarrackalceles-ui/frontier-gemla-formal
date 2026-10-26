import FrontierGEMLA.Ladder.S1Promotion
import FrontierGEMLA.Ladder.S1Identity

/-!
Typed proof-carrying promotion packet for S1.

Primary sources:
- Dual-Track Addendum v5.3, sections 7 and 8.
- Eqs. AD-16 and AD-19--AD-22.
- FrontierGEMLA AEL / S3 provisional draft, section A.6.

The source describes a promotion packet that can bind successor identity,
the proposed persistent delta, capability and operational evidence,
constitutional evidence, recovery information, semantic/version identity,
and independent verifier evidence.

This module treats those items as typed payloads. Possession of the packet
does not itself establish that its evidence is sufficient. Qualification
remains a separate proposition evaluated through the existing S1
acceptance and protected-verifier model.
-/

namespace FrontierGEMLA

/--
Typed evidence packet for a proposed first-order S1 successor.

The payload types remain generic because the source specifies the required
roles of the objects but does not prescribe one concrete representation
for deltas, evidence, recovery references, verifier evidence, or semantic
versions.
-/
structure S1PromotionPacket
    (γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer : Type) where
  sourceGeneration       : GenerationId γ
  candidateGeneration    : GenerationId γ
  constitution           : ConstitutionRef κ
  proposedDelta          : δ
  capabilityEvidence     : capEv
  operationalEvidence    : opsEv
  constitutionalEvidence : constEv
  recoveryReference      : recoveryRef
  verifierEvidence       : verifierEv
  semanticVersion        : semanticVer

/--
A typed packet is qualified only when its three evidence families satisfy
the existing AD-16 acceptance terms and its independent verifier evidence
passes the declared verifier predicate.
-/
def S1PromotionPacketQualified
    {γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer : Type}
    (capOK : capEv → Prop)
    (opsOK : opsEv → Prop)
    (constOK : constEv → Prop)
    (verifierOK : verifierEv → Prop)
    (packet :
      S1PromotionPacket
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer) :
    Prop :=
  S1PromotionQualified
    (capOK packet.capabilityEvidence)
    (opsOK packet.operationalEvidence)
    (constOK packet.constitutionalEvidence)
    (verifierOK packet.verifierEvidence)

/--
Qualification of a typed packet requires AD-16 S1 acceptance of the
packet's capability, operational, and constitutional evidence.
-/
theorem s1PromotionPacketQualified_requires_acceptance
    {γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer : Type}
    (capOK : capEv → Prop)
    (opsOK : opsEv → Prop)
    (constOK : constEv → Prop)
    (verifierOK : verifierEv → Prop)
    (packet :
      S1PromotionPacket
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer)
    (h : S1PromotionPacketQualified
      capOK opsOK constOK verifierOK packet) :
    AcceptS1
      (capOK packet.capabilityEvidence)
      (opsOK packet.operationalEvidence)
      (constOK packet.constitutionalEvidence) := by
  unfold S1PromotionPacketQualified at h
  exact
    s1PromotionQualified_requires_acceptance
      (capOK packet.capabilityEvidence)
      (opsOK packet.operationalEvidence)
      (constOK packet.constitutionalEvidence)
      (verifierOK packet.verifierEvidence)
      h

/--
Qualification requires the packet's capability evidence to satisfy its
declared evidence predicate.
-/
theorem s1PromotionPacketQualified_requires_capability
    {γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer : Type}
    (capOK : capEv → Prop)
    (opsOK : opsEv → Prop)
    (constOK : constEv → Prop)
    (verifierOK : verifierEv → Prop)
    (packet :
      S1PromotionPacket
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer)
    (h : S1PromotionPacketQualified
      capOK opsOK constOK verifierOK packet) :
    capOK packet.capabilityEvidence := by
  exact
    acceptS1_requires_capability
      (capOK packet.capabilityEvidence)
      (opsOK packet.operationalEvidence)
      (constOK packet.constitutionalEvidence)
      (s1PromotionPacketQualified_requires_acceptance
        capOK opsOK constOK verifierOK packet h)

/--
Qualification requires the packet's operational evidence to satisfy its
declared evidence predicate.
-/
theorem s1PromotionPacketQualified_requires_operations
    {γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer : Type}
    (capOK : capEv → Prop)
    (opsOK : opsEv → Prop)
    (constOK : constEv → Prop)
    (verifierOK : verifierEv → Prop)
    (packet :
      S1PromotionPacket
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer)
    (h : S1PromotionPacketQualified
      capOK opsOK constOK verifierOK packet) :
    opsOK packet.operationalEvidence := by
  exact
    acceptS1_requires_operations
      (capOK packet.capabilityEvidence)
      (opsOK packet.operationalEvidence)
      (constOK packet.constitutionalEvidence)
      (s1PromotionPacketQualified_requires_acceptance
        capOK opsOK constOK verifierOK packet h)

/--
Qualification requires the packet's constitutional evidence to satisfy
its declared evidence predicate.
-/
theorem s1PromotionPacketQualified_requires_constitution
    {γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer : Type}
    (capOK : capEv → Prop)
    (opsOK : opsEv → Prop)
    (constOK : constEv → Prop)
    (verifierOK : verifierEv → Prop)
    (packet :
      S1PromotionPacket
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer)
    (h : S1PromotionPacketQualified
      capOK opsOK constOK verifierOK packet) :
    constOK packet.constitutionalEvidence := by
  exact
    acceptS1_requires_constitution
      (capOK packet.capabilityEvidence)
      (opsOK packet.operationalEvidence)
      (constOK packet.constitutionalEvidence)
      (s1PromotionPacketQualified_requires_acceptance
        capOK opsOK constOK verifierOK packet h)

/--
Qualification requires the independent verifier evidence to satisfy its
declared verifier predicate.
-/
theorem s1PromotionPacketQualified_requires_verifier
    {γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer : Type}
    (capOK : capEv → Prop)
    (opsOK : opsEv → Prop)
    (constOK : constEv → Prop)
    (verifierOK : verifierEv → Prop)
    (packet :
      S1PromotionPacket
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer)
    (h : S1PromotionPacketQualified
      capOK opsOK constOK verifierOK packet) :
    verifierOK packet.verifierEvidence := by
  unfold S1PromotionPacketQualified at h
  exact
    s1PromotionQualified_requires_verifier
      (capOK packet.capabilityEvidence)
      (opsOK packet.operationalEvidence)
      (constOK packet.constitutionalEvidence)
      (verifierOK packet.verifierEvidence)
      h

/--
Evidence satisfying all three AD-16 terms together with successful
independent verifier evidence is sufficient to qualify the packet.
-/
theorem s1PromotionPacketQualified_of_evidence
    {γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer : Type}
    (capOK : capEv → Prop)
    (opsOK : opsEv → Prop)
    (constOK : constEv → Prop)
    (verifierOK : verifierEv → Prop)
    (packet :
      S1PromotionPacket
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer)
    (hCap : capOK packet.capabilityEvidence)
    (hOps : opsOK packet.operationalEvidence)
    (hConst : constOK packet.constitutionalEvidence)
    (hVerifier : verifierOK packet.verifierEvidence) :
    S1PromotionPacketQualified
      capOK opsOK constOK verifierOK packet := by
  unfold S1PromotionPacketQualified
  exact
    ⟨acceptS1_of_required_terms
        (capOK packet.capabilityEvidence)
        (opsOK packet.operationalEvidence)
        (constOK packet.constitutionalEvidence)
        hCap hOps hConst,
     hVerifier⟩

/--
Possession of a typed promotion packet does not itself establish
qualification. The evidence predicates remain independent judgments.
-/
theorem s1PromotionPacket_does_not_self_qualify
    {γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer : Type}
    (packet :
      S1PromotionPacket
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer) :
    ¬ S1PromotionPacketQualified
      (fun _ => False)
      (fun _ => True)
      (fun _ => True)
      (fun _ => True)
      packet := by
  intro h
  exact
    s1PromotionPacketQualified_requires_capability
      (fun _ => False)
      (fun _ => True)
      (fun _ => True)
      (fun _ => True)
      packet
      h

end FrontierGEMLA
