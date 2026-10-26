import FrontierGEMLA.Ladder.S1Admission
import FrontierGEMLA.Ladder.S2NonEscalation
import FrontierGEMLA.Ladder.S3ClaimGate

/-!
Cross-phase recursive-development evidence binding.

This module connects the concrete S1 and S2 formal objects to the
recursive-development requirements used by the S3 claim gate.

The S3 source requires:
- at least two independently audited accepted self-improvement
  generations; and
- an accepted second-order improvement process.

Rather than representing those requirements only by an unbound natural
number and an arbitrary evidence type, this module packages:
1. two valid S1 admission records;
2. distinct activated generation identities;
3. explicit independent-audit evidence; and
4. one valid governed S2 admission.

The actual S3 claim-gate constructor is left to the next bridge slice.
-/

namespace FrontierGEMLA

/--
Two concrete S1 generations together with evidence that their acceptance
was independently audited.
-/
structure S1AcceptedGenerationPair
    (γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
      activationEv auditEv : Type) where
  first :
    S1AdmissionRecord
      γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
      activationEv
  second :
    S1AdmissionRecord
      γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
      activationEv
  independentAuditEvidence : auditEv

/--
The S1 generation pair is valid only when:
1. the first generation is a valid S1 admission;
2. the second generation is a valid S1 admission;
3. their activated generation identities are distinct; and
4. the declared independent-audit evidence passes.
-/
def S1AcceptedGenerationPairValid
    {γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
      activationEv auditEv : Type}
    (capOK : capEv → Prop)
    (opsOK : opsEv → Prop)
    (constOK : constEv → Prop)
    (verifierOK : verifierEv → Prop)
    (activationOK : activationEv → Prop)
    (auditIndependent : auditEv → Prop)
    (pair :
      S1AcceptedGenerationPair
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
        activationEv auditEv) :
    Prop :=
  S1AdmissionRecordValid
      capOK opsOK constOK verifierOK activationOK pair.first ∧
  S1AdmissionRecordValid
      capOK opsOK constOK verifierOK activationOK pair.second ∧
  pair.first.activatedGeneration ≠ pair.second.activatedGeneration ∧
  auditIndependent pair.independentAuditEvidence

/--
A concrete accepted-generation pair contributes exactly two accepted
generations to the S3 minimum-count requirement.
-/
def S1AcceptedGenerationPair.acceptedGenerationCount
    {γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
      activationEv auditEv : Type}
    (_pair :
      S1AcceptedGenerationPair
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
        activationEv auditEv) :
    Nat :=
  2

/--
Valid pair evidence requires validity of the first concrete S1
generation.
-/
theorem s1AcceptedGenerationPairValid_requires_first
    {γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
      activationEv auditEv : Type}
    (capOK : capEv → Prop)
    (opsOK : opsEv → Prop)
    (constOK : constEv → Prop)
    (verifierOK : verifierEv → Prop)
    (activationOK : activationEv → Prop)
    (auditIndependent : auditEv → Prop)
    (pair :
      S1AcceptedGenerationPair
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
        activationEv auditEv)
    (h :
      S1AcceptedGenerationPairValid
        capOK opsOK constOK verifierOK activationOK
        auditIndependent pair) :
    S1AdmissionRecordValid
      capOK opsOK constOK verifierOK activationOK pair.first := by
  exact h.1

/--
Valid pair evidence requires validity of the second concrete S1
generation.
-/
theorem s1AcceptedGenerationPairValid_requires_second
    {γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
      activationEv auditEv : Type}
    (capOK : capEv → Prop)
    (opsOK : opsEv → Prop)
    (constOK : constEv → Prop)
    (verifierOK : verifierEv → Prop)
    (activationOK : activationEv → Prop)
    (auditIndependent : auditEv → Prop)
    (pair :
      S1AcceptedGenerationPair
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
        activationEv auditEv)
    (h :
      S1AcceptedGenerationPairValid
        capOK opsOK constOK verifierOK activationOK
        auditIndependent pair) :
    S1AdmissionRecordValid
      capOK opsOK constOK verifierOK activationOK pair.second := by
  exact h.2.1

/--
The two accepted S1 records must represent distinct activated
generations.
-/
theorem s1AcceptedGenerationPairValid_requires_distinct_generations
    {γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
      activationEv auditEv : Type}
    (capOK : capEv → Prop)
    (opsOK : opsEv → Prop)
    (constOK : constEv → Prop)
    (verifierOK : verifierEv → Prop)
    (activationOK : activationEv → Prop)
    (auditIndependent : auditEv → Prop)
    (pair :
      S1AcceptedGenerationPair
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
        activationEv auditEv)
    (h :
      S1AcceptedGenerationPairValid
        capOK opsOK constOK verifierOK activationOK
        auditIndependent pair) :
    pair.first.activatedGeneration ≠
      pair.second.activatedGeneration := by
  exact h.2.2.1

/--
The accepted-generation pair requires the explicit independent-audit
condition.
-/
theorem s1AcceptedGenerationPairValid_requires_independent_audit
    {γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
      activationEv auditEv : Type}
    (capOK : capEv → Prop)
    (opsOK : opsEv → Prop)
    (constOK : constEv → Prop)
    (verifierOK : verifierEv → Prop)
    (activationOK : activationEv → Prop)
    (auditIndependent : auditEv → Prop)
    (pair :
      S1AcceptedGenerationPair
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
        activationEv auditEv)
    (h :
      S1AcceptedGenerationPairValid
        capOK opsOK constOK verifierOK activationOK
        auditIndependent pair) :
    auditIndependent pair.independentAuditEvidence := by
  exact h.2.2.2

/--
A valid concrete generation pair satisfies the S3 minimum requirement
of at least two accepted generations.
-/
theorem s1AcceptedGenerationPairValid_meets_minimum_count
    {γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
      activationEv auditEv : Type}
    (capOK : capEv → Prop)
    (opsOK : opsEv → Prop)
    (constOK : constEv → Prop)
    (verifierOK : verifierEv → Prop)
    (activationOK : activationEv → Prop)
    (auditIndependent : auditEv → Prop)
    (pair :
      S1AcceptedGenerationPair
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
        activationEv auditEv)
    (h :
      S1AcceptedGenerationPairValid
        capOK opsOK constOK verifierOK activationOK
        auditIndependent pair) :
    2 ≤ pair.acceptedGenerationCount := by
  have _hFirst := h.1
  exact Nat.le_refl 2

/--
Concrete recursive-development evidence for the S3 bridge:
two accepted S1 generations plus a governed S2 improvement.
-/
structure S3RecursiveDevelopmentEvidence
    (γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
      activationEv auditEv
      improver capHist opsHist constHist selfInv
      s2VerifierEv s2RecoveryEv s2ActivationEv : Type) where
  acceptedGenerations :
    S1AcceptedGenerationPair
      γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
      activationEv auditEv

  secondOrder :
    S2GovernedAdmission
      improver capHist opsHist constHist selfInv
      s2VerifierEv s2RecoveryEv s2ActivationEv

/--
The concrete recursive-development package is valid only when both the
S1 generation-pair evidence and the governed S2 evidence are valid.
-/
def S3RecursiveDevelopmentEvidenceValid
    {γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
      activationEv auditEv
      improver capHist opsHist constHist selfInv
      s2VerifierEv s2RecoveryEv s2ActivationEv : Type}
    (capOK : capEv → Prop)
    (opsOK : opsEv → Prop)
    (constOK : constEv → Prop)
    (verifierOK : verifierEv → Prop)
    (activationOK : activationEv → Prop)
    (auditIndependent : auditEv → Prop)
    (capHistoryOK : capHist → Prop)
    (opsHistoryOK : opsHist → Prop)
    (constHistoryOK : constHist → Prop)
    (candidateImproverOK : improver → Prop)
    (selfInvariantOK : selfInv → Prop)
    (s2VerifierOK : s2VerifierEv → Prop)
    (s2RecoveryOK : s2RecoveryEv → Prop)
    (s2ActivationOK : s2ActivationEv → Prop)
    (evidence :
      S3RecursiveDevelopmentEvidence
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
        activationEv auditEv
        improver capHist opsHist constHist selfInv
        s2VerifierEv s2RecoveryEv s2ActivationEv) :
    Prop :=
  S1AcceptedGenerationPairValid
      capOK opsOK constOK verifierOK activationOK
      auditIndependent evidence.acceptedGenerations ∧
  S2GovernedAdmissionValid
      capHistoryOK opsHistoryOK constHistoryOK
      candidateImproverOK selfInvariantOK
      s2VerifierOK s2RecoveryOK s2ActivationOK
      evidence.secondOrder

/--
Valid recursive-development evidence requires the concrete S1
generation pair.
-/
theorem s3RecursiveDevelopmentEvidenceValid_requires_s1_pair
    {γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
      activationEv auditEv
      improver capHist opsHist constHist selfInv
      s2VerifierEv s2RecoveryEv s2ActivationEv : Type}
    (capOK : capEv → Prop)
    (opsOK : opsEv → Prop)
    (constOK : constEv → Prop)
    (verifierOK : verifierEv → Prop)
    (activationOK : activationEv → Prop)
    (auditIndependent : auditEv → Prop)
    (capHistoryOK : capHist → Prop)
    (opsHistoryOK : opsHist → Prop)
    (constHistoryOK : constHist → Prop)
    (candidateImproverOK : improver → Prop)
    (selfInvariantOK : selfInv → Prop)
    (s2VerifierOK : s2VerifierEv → Prop)
    (s2RecoveryOK : s2RecoveryEv → Prop)
    (s2ActivationOK : s2ActivationEv → Prop)
    (evidence :
      S3RecursiveDevelopmentEvidence
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
        activationEv auditEv
        improver capHist opsHist constHist selfInv
        s2VerifierEv s2RecoveryEv s2ActivationEv)
    (h :
      S3RecursiveDevelopmentEvidenceValid
        capOK opsOK constOK verifierOK activationOK auditIndependent
        capHistoryOK opsHistoryOK constHistoryOK
        candidateImproverOK selfInvariantOK
        s2VerifierOK s2RecoveryOK s2ActivationOK evidence) :
    S1AcceptedGenerationPairValid
      capOK opsOK constOK verifierOK activationOK
      auditIndependent evidence.acceptedGenerations := by
  exact h.1

/--
Valid recursive-development evidence requires the actual governed S2
improvement to be valid.
-/
theorem s3RecursiveDevelopmentEvidenceValid_requires_s2
    {γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
      activationEv auditEv
      improver capHist opsHist constHist selfInv
      s2VerifierEv s2RecoveryEv s2ActivationEv : Type}
    (capOK : capEv → Prop)
    (opsOK : opsEv → Prop)
    (constOK : constEv → Prop)
    (verifierOK : verifierEv → Prop)
    (activationOK : activationEv → Prop)
    (auditIndependent : auditEv → Prop)
    (capHistoryOK : capHist → Prop)
    (opsHistoryOK : opsHist → Prop)
    (constHistoryOK : constHist → Prop)
    (candidateImproverOK : improver → Prop)
    (selfInvariantOK : selfInv → Prop)
    (s2VerifierOK : s2VerifierEv → Prop)
    (s2RecoveryOK : s2RecoveryEv → Prop)
    (s2ActivationOK : s2ActivationEv → Prop)
    (evidence :
      S3RecursiveDevelopmentEvidence
        γ κ δ capEv opsEv constEv recoveryRef verifierEv semanticVer
        activationEv auditEv
        improver capHist opsHist constHist selfInv
        s2VerifierEv s2RecoveryEv s2ActivationEv)
    (h :
      S3RecursiveDevelopmentEvidenceValid
        capOK opsOK constOK verifierOK activationOK auditIndependent
        capHistoryOK opsHistoryOK constHistoryOK
        candidateImproverOK selfInvariantOK
        s2VerifierOK s2RecoveryOK s2ActivationOK evidence) :
    S2GovernedAdmissionValid
      capHistoryOK opsHistoryOK constHistoryOK
      candidateImproverOK selfInvariantOK
      s2VerifierOK s2RecoveryOK s2ActivationOK
      evidence.secondOrder := by
  exact h.2

end FrontierGEMLA
