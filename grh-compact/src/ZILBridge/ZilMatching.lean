import ZILBridge.ZilLeastModel
namespace Zil.Datalog
theorem unify_sound {pattern : Pattern} {atom : Atom} {substitution result : Substitution}
    (h : unify pattern atom substitution = some result) :
    pattern.relation = atom.relation := by
  unfold unify at h
  split at h
  · assumption
  · simp at h
theorem instantiate_sound {pattern : Pattern} {substitution : Substitution}
    {atom : Atom} (h : instantiate pattern substitution = some atom) :
    atom.relation = pattern.relation := by
  unfold instantiate at h
  cases pattern <;> simp_all
end Zil.Datalog
