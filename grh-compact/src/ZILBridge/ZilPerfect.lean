import ZILBridge.ZilCertify
import ZILBridge.ZilMatching
namespace Zil.Datalog
theorem deriveProgramChecked_sound {program : Program} {fuel : Nat} {facts : List Atom}
    (h : deriveProgramChecked program fuel = .ok facts) :
    ∀ atom, atom ∈ facts → Holds program atom := by
  intro atom hmem
  unfold deriveProgramChecked at h
  split at h
  · simp at h
    subst facts
    exact derive_sound program fuel atom (by simpa [deriveStratified] using hmem)
  · simp at h
end Zil.Datalog
