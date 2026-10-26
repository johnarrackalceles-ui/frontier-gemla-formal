import FrontierGEMLA.Ladder.S1AcceptanceClosure

/-!
Minimal protected-promotion consequences for S1.

Primary sources:
- Dual-Track Addendum v5.3, sections 7, 7.2 and 8.
- Eq. AD-16 and Eqs. AD-19--AD-22.
- FrontierGEMLA AEL / S3 provisional draft, recursive
  self-observation and proof-carrying improvement section.

The source distinguishes:
1. acceptance of a proposed S1 change;
2. independent protected verification before persistent admission;
3. activation of the admitted successor;
4. a separate consequential-authority grant.

This module captures only those logical separations. It does not yet
formalize the complete proof-carrying promotion packet or authority
protocol.
-/

namespace FrontierGEMLA

/--
A successor is promotion-qualified only when the existing AD-16
acceptance rule holds and the independent protected verifier passes.
-/
def S1PromotionQualified
    (pCap pOps pConst verifierPass : Prop) : Prop :=
  AcceptS1 pCap pOps pConst ∧ verifierPass

/--
Activation is separate from qualification for protected promotion.
-/
def S1SuccessorActivated
    (pCap pOps pConst verifierPass activation : Prop) : Prop :=
  S1PromotionQualified pCap pOps pConst verifierPass ∧ activation

/--
Consequential authority remains separate from successor activation.
-/
def S1SuccessorAuthorized
    (pCap pOps pConst verifierPass activation authorityGrant : Prop) : Prop :=
  S1SuccessorActivated pCap pOps pConst verifierPass activation ∧
    authorityGrant

/--
Promotion qualification requires S1 acceptance.
-/
theorem s1PromotionQualified_requires_acceptance
    (pCap pOps pConst verifierPass : Prop)
    (h : S1PromotionQualified pCap pOps pConst verifierPass) :
    AcceptS1 pCap pOps pConst := by
  exact h.1

/--
Promotion qualification requires the independent verifier to pass.
-/
theorem s1PromotionQualified_requires_verifier
    (pCap pOps pConst verifierPass : Prop)
    (h : S1PromotionQualified pCap pOps pConst verifierPass) :
    verifierPass := by
  exact h.2

/--
An activated S1 successor must already satisfy the protected-promotion
qualification.
-/
theorem s1SuccessorActivated_requires_promotion
    (pCap pOps pConst verifierPass activation : Prop)
    (h : S1SuccessorActivated
      pCap pOps pConst verifierPass activation) :
    S1PromotionQualified pCap pOps pConst verifierPass := by
  exact h.1

/--
Consequentially authorized use requires successor activation.
-/
theorem s1SuccessorAuthorized_requires_activation
    (pCap pOps pConst verifierPass activation authorityGrant : Prop)
    (h : S1SuccessorAuthorized
      pCap pOps pConst verifierPass activation authorityGrant) :
    S1SuccessorActivated pCap pOps pConst verifierPass activation := by
  exact h.1

/--
S1 acceptance alone does not establish protected-promotion
qualification: the independent verifier may still fail.
-/
theorem acceptS1_can_hold_without_promotion_qualification :
    AcceptS1 True True True ∧
      ¬ S1PromotionQualified True True True False := by
  constructor
  · exact acceptS1_of_required_terms True True True trivial trivial trivial
  · intro h
    exact h.2

/--
Protected-promotion qualification does not itself establish activation.
-/
theorem promotion_qualification_can_hold_without_activation :
    S1PromotionQualified True True True True ∧
      ¬ S1SuccessorActivated True True True True False := by
  constructor
  · exact
      ⟨acceptS1_of_required_terms True True True trivial trivial trivial,
       trivial⟩
  · intro h
    exact h.2

/--
Successor activation does not itself grant consequential authority.
-/
theorem activation_can_hold_without_authority :
    S1SuccessorActivated True True True True True ∧
      ¬ S1SuccessorAuthorized True True True True True False := by
  constructor
  · exact
      ⟨⟨acceptS1_of_required_terms True True True trivial trivial trivial,
          trivial⟩,
       trivial⟩
  · intro h
    exact h.2

end FrontierGEMLA
