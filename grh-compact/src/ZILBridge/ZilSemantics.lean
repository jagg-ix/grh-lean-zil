import ZILBridge.ZilEval
namespace Zil.Datalog
inductive Derives (program : Program) : Atom → Prop where
  | fact {atom : Atom} : atom ∈ program.facts → Derives program atom
  | rule {atom : Atom} (rule : Rule) (support : List Atom) :
      rule ∈ program.rules →
      (∀ candidate, candidate ∈ support → Derives program candidate) →
      atom ∈ applyRule support rule → Derives program atom
theorem derive_sound (program : Program) (fuel : Nat) (atom : Atom)
    (h : atom ∈ derive program fuel) : Derives program atom := by
  induction fuel generalizing atom with
  | zero =>
      apply Derives.fact
      simpa [derive] using h
  | succ fuel ih =>
      unfold derive at h
      simp only [deriveStep, List.mem_eraseDups, List.mem_append, List.mem_flatMap] at h
      rcases h with hprev | ⟨rule, hrule, hatom⟩
      · exact ih atom hprev
      · exact Derives.rule rule (derive program fuel) hrule
          (fun candidate hc => ih candidate hc) hatom
def Holds (program : Program) (atom : Atom) : Prop := Derives program atom
end Zil.Datalog
