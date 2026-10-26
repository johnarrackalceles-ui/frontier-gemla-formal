namespace FrontierGEMLA

/--
The two evidence tracks.

Source: Dual-Track Addendum, dual-track development ladder.
-/
inductive Track where
  | A | B
  deriving DecidableEq, Repr

/--
Stages inside a track from G2 through C2.

Source: Dual-Track Addendum, development ladder.
-/
inductive Stage where
  | G2 | G3 | G4 | C1 | C2
  deriving DecidableEq, Repr

/--
A track-qualified ladder node. For example, G3-A is
`(Stage.G3, Track.A)`.
-/
abbrev Node := Stage × Track

/--
Determination values.

UNKNOWN is distinct from NO; this is intentionally a three-valued
determination rather than a Bool.

Source: scope revision 17, section 1.8 and D4.
-/
inductive Det where
  | no | unknown | yes
  deriving DecidableEq, Repr

/--
Possible S1 evaluation outcomes.

Source: Dual-Track Addendum section 7.2.
-/
inductive Outcome where
  | accept | hold | reject | recover
  deriving DecidableEq, Repr

end FrontierGEMLA
