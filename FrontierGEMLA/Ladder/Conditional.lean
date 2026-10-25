import FrontierGEMLA.Shared.Types

namespace FrontierGEMLA

structure ConditionalResult where
  node   : Node
  labels : List Node

def ConditionalResult.buildOn
    (r : ConditionalResult) (n : Node) (now : List Node) :
    ConditionalResult :=
  { node := n, labels := r.labels ++ now }

theorem ConditionalResult.label_inherited
    (r : ConditionalResult) (n : Node) (now : List Node) (x : Node)
    (hx : x ∈ r.labels) : x ∈ (r.buildOn n now).labels := by
  unfold ConditionalResult.buildOn
  exact List.mem_append_left now hx

end FrontierGEMLA
