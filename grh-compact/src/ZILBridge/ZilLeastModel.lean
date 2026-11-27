import ZILBridge.ZilModel
namespace Zil.Datalog
theorem derive_sound_in_interpretation (program : Program) (fuel : Nat)
    (atom : Atom) (h : atom ∈ derive program fuel) :
    atom ∈ derive program fuel ∧ Derives program atom :=
  ⟨h, derive_sound program fuel atom h⟩
end Zil.Datalog
