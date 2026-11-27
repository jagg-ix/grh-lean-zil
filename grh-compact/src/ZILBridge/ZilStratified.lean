import ZILBridge.ZilLeastModel
namespace Zil.Datalog
def deriveStratified (program : Program) (fuel : Nat) : List Atom :=
  let levels := List.range (program.maxStratum + 1)
  levels.foldl (fun facts stratum =>
    let rules := program.rules.filter fun rule => program.stratumOf rule.head.relation == stratum
    (facts ++ rules.flatMap (applyRule facts)).eraseDups) program.facts
theorem deriveStratified_contains_fact (program : Program) (fuel : Nat)
    {atom : Atom} (h : atom ∈ program.facts) :
    atom ∈ deriveStratified program fuel := by
  simp [deriveStratified, h]
end Zil.Datalog
