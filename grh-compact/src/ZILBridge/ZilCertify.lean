import ZILBridge.ZilChecked
namespace Zil.Datalog
structure CertNode where
  atom : Atom
  origin : Option (String × List Nat) := none
  deriving Repr, DecidableEq, Inhabited
abbrev Certificate := List CertNode
def checkCertificate (program : Program) (certificate : Certificate) : Bool :=
  certificate.all fun node =>
    match node.origin with
    | none => program.facts.contains node.atom
    | some _ => false
theorem checkCertificate_sound {program : Program} {certificate : Certificate}
    (h : checkCertificate program certificate = true) :
    ∀ node, node ∈ certificate → node.atom ∈ program.facts := by
  intro node hnode
  have hall := List.all_eq_true.mp h node hnode
  unfold checkCertificate at hall
  cases hOrigin : node.origin <;> simp_all
end Zil.Datalog
