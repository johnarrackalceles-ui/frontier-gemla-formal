namespace FrontierGEMLA

inductive Track where
  | A | B
  deriving DecidableEq, Repr

inductive Stage where
  | G2 | G3 | G4 | C1 | C2
  deriving DecidableEq, Repr

abbrev Node := Stage × Track

inductive Det where
  | no | unknown | yes
  deriving DecidableEq, Repr

inductive Outcome where
  | accept | hold | reject | recover
  deriving DecidableEq, Repr

end FrontierGEMLA
