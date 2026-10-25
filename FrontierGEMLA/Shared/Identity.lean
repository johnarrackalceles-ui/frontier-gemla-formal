namespace FrontierGEMLA

/--
Identity of a governed operational generation.

The underlying representation is deliberately left abstract here.
The addendum requires generation identity consistency but does not
prescribe a concrete serialization for the formal model.
-/
structure GenerationId (α : Type) where
  value : α

/--
Reference identifying the constitutional substrate used by a track.

This is a formalization device for the addendum's requirement that
S1 entry use a shared constitution. The source does not prescribe a
concrete identifier representation.
-/
structure ConstitutionRef (α : Type) where
  value : α

end FrontierGEMLA
