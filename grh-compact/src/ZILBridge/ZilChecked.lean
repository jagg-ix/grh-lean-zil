import ZILBridge.ZilStratified
namespace Zil.Datalog
def defaultFuel : Nat := 1000000
def deriveProgramChecked (program : Program) (fuel : Nat := defaultFuel) :
    Except String (List Atom) :=
  if program.isStratified then .ok (deriveStratified program fuel)
  else .error "the program is not stratified"
theorem holds_of_checked {program : Program} {atom : Atom}
    (h : atom ∈ (deriveProgramChecked program).toOption.getD []) : Holds program atom := by
  unfold deriveProgramChecked at h
  split at h
  · exact derive_sound program defaultFuel atom (by simpa [derive] using h)
  · simp at h
theorem not_holds_of_checked {program : Program} {atom : Atom}
    (h : atom ∉ (deriveProgramChecked program).toOption.getD []) :
    ¬ Holds program atom := by
  intro hh
  cases hh with
  | fact hfact => simp [deriveProgramChecked, deriveStratified, hfact] at h
end Zil.Datalog
