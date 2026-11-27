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
public import Zil.Datalog.Environment
public meta import Zil.Datalog.Attach
public meta import Zil.Datalog.EmbeddedValidation
public import Zil.Datalog.Tactic.Solve
public import Zil.Datalog.Workflow
public meta import Zil.Datalog.Claim
public meta import Zil.Datalog.FormalizationContract
public import Zil.Datalog.Relation
public import Zil.Datalog.RelationEval
public import Zil.Datalog.RelationEnvironment
public import Zil.Datalog.Revision
public meta import Zil.Datalog.Index
public meta import Zil.Datalog.Interop
public import Zil.Datalog.Compat

/-!
# ZIL Datalog surface

This curated root exposes the upstream Lean-embedded Datalog DSL, relation
model, checked evaluator, proof/certificate surface, declaration attachments,
claim attributes, and formalization-contract commands. The separate ZIL.Native
application stack, external parser, CLI, worker, and Horn subsystem are not
part of this GRH integration.
-/
