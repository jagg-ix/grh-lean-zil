import ZILBridge.ZilUnify
namespace Zil.Datalog
def matchPattern (facts : List Atom) (pattern : Pattern)
    (substitution : Substitution) : List Substitution :=
  facts.filterMap fun atom => unify pattern atom substitution
def satisfyBody (facts : List Atom) (body : List Pattern) : List Substitution :=
  body.foldl (fun substitutions pattern => substitutions.flatMap (matchPattern facts pattern)) [[]]
def excludesPattern (facts : List Atom) (pattern : Pattern) (substitution : Substitution) : Bool :=
  !(facts.any fun atom => (unify pattern atom substitution).isSome)
def satisfyNegativeBody (facts : List Atom) (body : List Pattern)
    (substitutions : List Substitution) : List Substitution :=
  body.foldl (fun states pattern => states.filter (fun state => excludesPattern facts pattern state))
    substitutions
def applyRule (facts : List Atom) (rule : Rule) : List Atom :=
  (satisfyNegativeBody facts rule.negativePatterns (satisfyBody facts rule.positiveBody)).filterMap
    (instantiate rule.head)
def deriveStep (program : Program) (facts : List Atom) : List Atom :=
  (facts ++ program.rules.flatMap (applyRule facts)).eraseDups
def derive (program : Program) : Nat → List Atom
  | 0 => program.facts.eraseDups
  | fuel + 1 => deriveStep program (derive program fuel)
end Zil.Datalog
