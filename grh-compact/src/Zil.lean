module

public import Zil.Datalog.Basic
public import Zil.Datalog.Unify
public import Zil.Datalog.Eval
public import Zil.Datalog.Semantics
public import Zil.Datalog.Model
public import Zil.Datalog.LeastModel
public import Zil.Datalog.Stratified
public import Zil.Datalog.Checked
public import Zil.Datalog.Certify
public import Zil.Datalog.Matching
public import Zil.Datalog.Perfect
public import Zil.Datalog.Tactic.Solve

/-!
# ZIL Datalog surface

A deliberately scoped root for the upstream Datalog model, evaluator,
semantics, checked evaluation, certificates, and proof tactics. This is not
the full upstream ZIL application package or its external parser/runtime.
-/
