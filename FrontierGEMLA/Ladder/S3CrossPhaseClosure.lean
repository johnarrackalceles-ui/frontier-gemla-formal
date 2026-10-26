import FrontierGEMLA.Ladder.S3GateBinding
import FrontierGEMLA.Ladder.S3BoundedClaim

/-!
Phase 6 cross-phase closure.

This module introduces no new capability or readiness semantics.

It closes the typed path from:
- two concrete, distinct, independently audited S1 admissions;
- one concrete governed S2 admission;
- the remaining S3 evidence obligations;

through the existing unified S3 claim gate and into the existing
benchmark-bounded S3 candidate claim.

It also records that valid recursive-development evidence cannot bypass
the remaining S3 capability obligations.
-/

namespace FrontierGEMLA

/--
The fully bound S3 claim combines:
1. the concrete cross-phase S3 gate; and
2. satisfaction of the declared benchmark envelope.

The ordinary S3 bounded-candidate claim remains the public claim
semantics; this predicate only preserves the stronger concrete
cross-phase provenance behind it.
-/
def S3CrossPhaseBoundedClaim
    {γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
      activationEv s1AuditEv
      improver capHist opsHist constHist selfInv
      s2VerifierEv s2RecoveryEv s2ActivationEv
      crossDomainEv unfamiliarEv transferEv architectureEv
      protocolEv constitutionEv recoveryEv authorityEv s3AuditEv
      benchmark : Type}
    (capOK : capEv → Prop)
    (opsOK : opsEv → Prop)
    (constOK : constEv → Prop)
    (verifierOK : verifierEv → Prop)
    (activationOK : activationEv → Prop)
    (auditIndependent : s1AuditEv → Prop)
    (capHistoryOK : capHist → Prop)
    (opsHistoryOK : opsHist → Prop)
    (constHistoryOK : constHist → Prop)
    (candidateImproverOK : improver → Prop)
    (selfInvariantOK : selfInv → Prop)
    (s2VerifierOK : s2VerifierEv → Prop)
    (s2RecoveryOK : s2RecoveryEv → Prop)
    (s2ActivationOK : s2ActivationEv → Prop)
    (crossDomainOK : crossDomainEv → Prop)
    (unfamiliarDomainOK : unfamiliarEv → Prop)
    (transferOK : transferEv → Prop)
    (architectureOptimizationOK : architectureEv → Prop)
    (evaluationProtocolFrozen : protocolEv → Prop)
    (constitutionPreserved : constitutionEv → Prop)
    (s3RecoveryOK : recoveryEv → Prop)
    (authoritySeparated : authorityEv → Prop)
    (auditScalable : s3AuditEv → Prop)
    (envelopeOK : benchmark → Prop)
    (evidence :
      S3CrossPhaseEvidence
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
        activationEv s1AuditEv
        improver capHist opsHist constHist selfInv
        s2VerifierEv s2RecoveryEv s2ActivationEv
        crossDomainEv unfamiliarEv transferEv architectureEv
        protocolEv constitutionEv recoveryEv authorityEv s3AuditEv)
    (envelope : S3ClaimEnvelope benchmark) :
    Prop :=
  S3CrossPhaseClaimGate
      capOK opsOK constOK verifierOK activationOK auditIndependent
      capHistoryOK opsHistoryOK constHistoryOK
      candidateImproverOK selfInvariantOK
      s2VerifierOK s2RecoveryOK s2ActivationOK
      crossDomainOK unfamiliarDomainOK transferOK
      architectureOptimizationOK evaluationProtocolFrozen
      constitutionPreserved s3RecoveryOK authoritySeparated
      auditScalable evidence ∧
  envelopeOK envelope.declaredBenchmark

section Closure

variable
  {γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
    activationEv s1AuditEv
    improver capHist opsHist constHist selfInv
    s2VerifierEv s2RecoveryEv s2ActivationEv
    crossDomainEv unfamiliarEv transferEv architectureEv
    protocolEv constitutionEv recoveryEv authorityEv s3AuditEv
    benchmark : Type}

variable
  (capOK : capEv → Prop)
  (opsOK : opsEv → Prop)
  (constOK : constEv → Prop)
  (verifierOK : verifierEv → Prop)
  (activationOK : activationEv → Prop)
  (auditIndependent : s1AuditEv → Prop)
  (capHistoryOK : capHist → Prop)
  (opsHistoryOK : opsHist → Prop)
  (constHistoryOK : constHist → Prop)
  (candidateImproverOK : improver → Prop)
  (selfInvariantOK : selfInv → Prop)
  (s2VerifierOK : s2VerifierEv → Prop)
  (s2RecoveryOK : s2RecoveryEv → Prop)
  (s2ActivationOK : s2ActivationEv → Prop)
  (crossDomainOK : crossDomainEv → Prop)
  (unfamiliarDomainOK : unfamiliarEv → Prop)
  (transferOK : transferEv → Prop)
  (architectureOptimizationOK : architectureEv → Prop)
  (evaluationProtocolFrozen : protocolEv → Prop)
  (constitutionPreserved : constitutionEv → Prop)
  (s3RecoveryOK : recoveryEv → Prop)
  (authoritySeparated : authorityEv → Prop)
  (auditScalable : s3AuditEv → Prop)
  (envelopeOK : benchmark → Prop)

/--
The fully bound claim requires the concrete cross-phase S3 gate.
-/
theorem s3CrossPhaseBoundedClaim_requires_cross_phase_gate
    (evidence :
      S3CrossPhaseEvidence
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
        activationEv s1AuditEv
        improver capHist opsHist constHist selfInv
        s2VerifierEv s2RecoveryEv s2ActivationEv
        crossDomainEv unfamiliarEv transferEv architectureEv
        protocolEv constitutionEv recoveryEv authorityEv s3AuditEv)
    (envelope : S3ClaimEnvelope benchmark)
    (h :
      S3CrossPhaseBoundedClaim
        capOK opsOK constOK verifierOK activationOK auditIndependent
        capHistoryOK opsHistoryOK constHistoryOK
        candidateImproverOK selfInvariantOK
        s2VerifierOK s2RecoveryOK s2ActivationOK
        crossDomainOK unfamiliarDomainOK transferOK
        architectureOptimizationOK evaluationProtocolFrozen
        constitutionPreserved s3RecoveryOK authoritySeparated
        auditScalable envelopeOK evidence envelope) :
    S3CrossPhaseClaimGate
      capOK opsOK constOK verifierOK activationOK auditIndependent
      capHistoryOK opsHistoryOK constHistoryOK
      candidateImproverOK selfInvariantOK
      s2VerifierOK s2RecoveryOK s2ActivationOK
      crossDomainOK unfamiliarDomainOK transferOK
      architectureOptimizationOK evaluationProtocolFrozen
      constitutionPreserved s3RecoveryOK authoritySeparated
      auditScalable evidence := by
  exact h.1

/--
The fully bound claim requires the declared benchmark envelope.
-/
theorem s3CrossPhaseBoundedClaim_requires_envelope
    (evidence :
      S3CrossPhaseEvidence
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
        activationEv s1AuditEv
        improver capHist opsHist constHist selfInv
        s2VerifierEv s2RecoveryEv s2ActivationEv
        crossDomainEv unfamiliarEv transferEv architectureEv
        protocolEv constitutionEv recoveryEv authorityEv s3AuditEv)
    (envelope : S3ClaimEnvelope benchmark)
    (h :
      S3CrossPhaseBoundedClaim
        capOK opsOK constOK verifierOK activationOK auditIndependent
        capHistoryOK opsHistoryOK constHistoryOK
        candidateImproverOK selfInvariantOK
        s2VerifierOK s2RecoveryOK s2ActivationOK
        crossDomainOK unfamiliarDomainOK transferOK
        architectureOptimizationOK evaluationProtocolFrozen
        constitutionPreserved s3RecoveryOK authoritySeparated
        auditScalable envelopeOK evidence envelope) :
    envelopeOK envelope.declaredBenchmark := by
  exact h.2

/--
The fully bound claim retains the concrete two-generation S1 evidence.
-/
theorem s3CrossPhaseBoundedClaim_requires_s1_pair
    (evidence :
      S3CrossPhaseEvidence
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
        activationEv s1AuditEv
        improver capHist opsHist constHist selfInv
        s2VerifierEv s2RecoveryEv s2ActivationEv
        crossDomainEv unfamiliarEv transferEv architectureEv
        protocolEv constitutionEv recoveryEv authorityEv s3AuditEv)
    (envelope : S3ClaimEnvelope benchmark)
    (h :
      S3CrossPhaseBoundedClaim
        capOK opsOK constOK verifierOK activationOK auditIndependent
        capHistoryOK opsHistoryOK constHistoryOK
        candidateImproverOK selfInvariantOK
        s2VerifierOK s2RecoveryOK s2ActivationOK
        crossDomainOK unfamiliarDomainOK transferOK
        architectureOptimizationOK evaluationProtocolFrozen
        constitutionPreserved s3RecoveryOK authoritySeparated
        auditScalable envelopeOK evidence envelope) :
    S1AcceptedGenerationPairValid
      capOK opsOK constOK verifierOK activationOK
      auditIndependent evidence.recursive.acceptedGenerations := by
  exact
    s3CrossPhaseClaimGate_requires_s1_pair
      capOK opsOK constOK verifierOK activationOK auditIndependent
      capHistoryOK opsHistoryOK constHistoryOK
      candidateImproverOK selfInvariantOK
      s2VerifierOK s2RecoveryOK s2ActivationOK
      crossDomainOK unfamiliarDomainOK transferOK
      architectureOptimizationOK evaluationProtocolFrozen
      constitutionPreserved s3RecoveryOK authoritySeparated
      auditScalable
      evidence h.1

/--
The fully bound claim retains the concrete governed S2 improvement.
-/
theorem s3CrossPhaseBoundedClaim_requires_s2
    (evidence :
      S3CrossPhaseEvidence
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
        activationEv s1AuditEv
        improver capHist opsHist constHist selfInv
        s2VerifierEv s2RecoveryEv s2ActivationEv
        crossDomainEv unfamiliarEv transferEv architectureEv
        protocolEv constitutionEv recoveryEv authorityEv s3AuditEv)
    (envelope : S3ClaimEnvelope benchmark)
    (h :
      S3CrossPhaseBoundedClaim
        capOK opsOK constOK verifierOK activationOK auditIndependent
        capHistoryOK opsHistoryOK constHistoryOK
        candidateImproverOK selfInvariantOK
        s2VerifierOK s2RecoveryOK s2ActivationOK
        crossDomainOK unfamiliarDomainOK transferOK
        architectureOptimizationOK evaluationProtocolFrozen
        constitutionPreserved s3RecoveryOK authoritySeparated
        auditScalable envelopeOK evidence envelope) :
    S2GovernedAdmissionValid
      capHistoryOK opsHistoryOK constHistoryOK
      candidateImproverOK selfInvariantOK
      s2VerifierOK s2RecoveryOK s2ActivationOK
      evidence.recursive.secondOrder := by
  exact
    s3CrossPhaseClaimGate_requires_s2
      capOK opsOK constOK verifierOK activationOK auditIndependent
      capHistoryOK opsHistoryOK constHistoryOK
      candidateImproverOK selfInvariantOK
      s2VerifierOK s2RecoveryOK s2ActivationOK
      crossDomainOK unfamiliarDomainOK transferOK
      architectureOptimizationOK evaluationProtocolFrozen
      constitutionPreserved s3RecoveryOK authoritySeparated
      auditScalable
      evidence h.1

/--
The fully bound cross-phase claim implies the already-defined public
bounded S3 candidate claim.
-/
theorem s3CrossPhaseBoundedClaim_implies_bounded_candidate_claim
    (evidence :
      S3CrossPhaseEvidence
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
        activationEv s1AuditEv
        improver capHist opsHist constHist selfInv
        s2VerifierEv s2RecoveryEv s2ActivationEv
        crossDomainEv unfamiliarEv transferEv architectureEv
        protocolEv constitutionEv recoveryEv authorityEv s3AuditEv)
    (envelope : S3ClaimEnvelope benchmark)
    (h :
      S3CrossPhaseBoundedClaim
        capOK opsOK constOK verifierOK activationOK auditIndependent
        capHistoryOK opsHistoryOK constHistoryOK
        candidateImproverOK selfInvariantOK
        s2VerifierOK s2RecoveryOK s2ActivationOK
        crossDomainOK unfamiliarDomainOK transferOK
        architectureOptimizationOK evaluationProtocolFrozen
        constitutionPreserved s3RecoveryOK authoritySeparated
        auditScalable envelopeOK evidence envelope) :
    S3BoundedCandidateClaim
      crossDomainOK
      unfamiliarDomainOK
      transferOK
      (fun secondOrder =>
        S2GovernedAdmissionValid
          capHistoryOK opsHistoryOK constHistoryOK
          candidateImproverOK selfInvariantOK
          s2VerifierOK s2RecoveryOK s2ActivationOK
          secondOrder)
      architectureOptimizationOK
      evaluationProtocolFrozen
      constitutionPreserved
      s3RecoveryOK
      authoritySeparated
      auditScalable
      envelopeOK
      evidence.toClaimEvidence
      envelope := by
  exact ⟨h.1.2, h.2⟩

/--
Concrete recursive-development evidence cannot bypass a failed
cross-domain S3 obligation.

Even valid S1/S2 recursive evidence is insufficient if the required
cross-domain capability predicate fails.
-/
theorem s3CrossPhaseClaimGate_fails_without_cross_domain
    (evidence :
      S3CrossPhaseEvidence
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
        activationEv s1AuditEv
        improver capHist opsHist constHist selfInv
        s2VerifierEv s2RecoveryEv s2ActivationEv
        crossDomainEv unfamiliarEv transferEv architectureEv
        protocolEv constitutionEv recoveryEv authorityEv s3AuditEv)
    (hFail :
      ¬ crossDomainOK evidence.crossDomainEvidence) :
    ¬ S3CrossPhaseClaimGate
      capOK opsOK constOK verifierOK activationOK auditIndependent
      capHistoryOK opsHistoryOK constHistoryOK
      candidateImproverOK selfInvariantOK
      s2VerifierOK s2RecoveryOK s2ActivationOK
      crossDomainOK unfamiliarDomainOK transferOK
      architectureOptimizationOK evaluationProtocolFrozen
      constitutionPreserved s3RecoveryOK authoritySeparated
      auditScalable evidence := by
  intro h
  have hGate :
      S3ClaimGate
        crossDomainOK
        unfamiliarDomainOK
        transferOK
        (fun secondOrder =>
          S2GovernedAdmissionValid
            capHistoryOK opsHistoryOK constHistoryOK
            candidateImproverOK selfInvariantOK
            s2VerifierOK s2RecoveryOK s2ActivationOK
            secondOrder)
        architectureOptimizationOK
        evaluationProtocolFrozen
        constitutionPreserved
        s3RecoveryOK
        authoritySeparated
        auditScalable
        evidence.toClaimEvidence :=
    h.2
  exact hFail hGate.crossDomainSuperiority

end Closure

end FrontierGEMLA
