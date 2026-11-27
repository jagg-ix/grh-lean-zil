import ZILBridge.ZilSemantics
namespace Zil.Datalog
abbrev Interpretation := List Atom
def Interpretation.SatisfiesAtom (model : Interpretation) (atom : Atom) : Prop := atom ∈ model
def Rule.bodySolutions (model : Interpretation) (rule : Rule) : List Substitution :=
  satisfyNegativeBody model rule.negativePatterns (satisfyBody model rule.positiveBody)
def RuleConsequence (model : Interpretation) (rule : Rule) (atom : Atom) : Prop :=
  ∃ substitution, substitution ∈ rule.bodySolutions model ∧
    instantiate rule.head substitution = some atom
structure IsStratifiedModel (program : Program) (model : Interpretation) : Prop where
  stratified : program.isStratified = true
  facts : ∀ atom, atom ∈ program.facts → atom ∈ model
  closed : ∀ rule, rule ∈ program.rules → ∀ atom,
    RuleConsequence model rule atom → atom ∈ model
theorem ruleConsequence_iff_applyRule_mem {model : Interpretation} {rule : Rule}
    {atom : Atom} : RuleConsequence model rule atom ↔ atom ∈ applyRule model rule := by
  simp [RuleConsequence, Rule.bodySolutions, applyRule, List.mem_filterMap]
end Zil.Datalog
