import ZILBridge.ZilBasic
namespace Zil.Datalog
def lookup (name : String) (substitution : Substitution) : Option Value :=
  substitution.lookup name
def bind (name : String) (value : Value) (substitution : Substitution) : Option Substitution :=
  match lookup name substitution with
  | none => some ((name, value) :: substitution)
  | some existing => if existing == value then some substitution else none
def unifyValue (term : Term) (value : Value) (substitution : Substitution) :
    Option Substitution :=
  match term with
  | .value expected => if expected == value then some substitution else none
  | .variable name => bind name value substitution
def unifyAttrs (patterns : PatternAttrs) (values : AtomAttrs)
    (substitution : Substitution) : Option Substitution :=
  patterns.foldlM (fun state (key, term) => do
    let value ← values.lookup key
    unifyValue term value state) substitution
def unify (pattern : Pattern) (atom : Atom) (substitution : Substitution) :
    Option Substitution := do
  if pattern.relation != atom.relation then none
  else
    let state ← unifyValue pattern.object atom.object substitution
    let state ← unifyValue pattern.subject atom.subject state
    unifyAttrs pattern.attrs atom.attrs state
def instantiateTerm (term : Term) (substitution : Substitution) : Option Value :=
  match term with
  | .value value => some value
  | .variable name => lookup name substitution
def instantiate (pattern : Pattern) (substitution : Substitution) : Option Atom := do
  let object ← instantiateTerm pattern.object substitution
  let subject ← instantiateTerm pattern.subject substitution
  let attrs ← pattern.attrs.mapM fun (key, term) => do
    let value ← instantiateTerm term substitution
    pure (key, value)
  pure { object, relation := pattern.relation, subject, attrs }
end Zil.Datalog
