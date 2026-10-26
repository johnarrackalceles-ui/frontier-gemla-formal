import FrontierGEMLA.Shared.Types

namespace FrontierGEMLA

/--
A result and its conditional label. `labels` names the open
predecessors on which the result remains conditional.

Source: Context section 22, item 4.
-/
structure ConditionalResult where
  node   : Node
  labels : List Node

/--
Build a later result on an earlier conditional result. Existing labels
are retained and the currently open predecessors are appended.

Source: Context section 22, item 4.
-/
def ConditionalResult.buildOn
    (r : ConditionalResult) (n : Node) (now : List Node) :
    ConditionalResult :=
  { node := n, labels := r.labels ++ now }

/--
A conditional predecessor label is never dropped when a later result
is built on the earlier result.

Source: Context section 22, item 4.
-/
theorem ConditionalResult.label_inherited
    (r : ConditionalResult) (n : Node) (now : List Node) (x : Node)
    (hx : x ∈ r.labels) : x ∈ (r.buildOn n now).labels := by
  unfold ConditionalResult.buildOn
  exact List.mem_append_left now hx

end FrontierGEMLA
