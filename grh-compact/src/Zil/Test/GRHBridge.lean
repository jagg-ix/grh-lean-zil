import Main
import Zil

open Lean Elab Command
open Zil.Datalog

/-!
# GRH declarations as ZIL claims

This module demonstrates how existing GRH declarations can be linked to
stable ZIL claim names and relation facts. The metadata is an index of the
Lean declarations; it does not change their types or prove the mapping
sound or complete.
-/

attribute [zil_claim claim.riemann_hypothesis] riemannHypothesis
attribute [zil_claim claim.riemann_zeta_zeros_on_line] riemannZeta_eq_zero_re
attribute [zil_claim claim.dirichlet_l_nonvanishing_right_of_half] LFunction_ne_zero_of_half_lt_re
attribute [zil_claim claim.dirichlet_l_zeros_on_line] LFunction_eq_zero_re
attribute [zil_claim claim.primitive_dirichlet_l_zeros_on_line] LFunction_eq_zero_re_of_isPrimitive

attribute [zil_concept concept.riemann_hypothesis] riemannHypothesis
attribute [zil_concept concept.riemann_zeta] riemannZeta_eq_zero_re
attribute [zil_concept concept.dirichlet_l_function] LFunction_ne_zero_of_half_lt_re
attribute [zil_concept concept.dirichlet_l_function] LFunction_eq_zero_re
attribute [zil_concept concept.dirichlet_l_function] LFunction_eq_zero_re_of_isPrimitive

zil attach riemannHypothesis where formalizes @ claim.riemann_hypothesis, has_type @ mathlib.RiemannHypothesis
zil attach riemannZeta_eq_zero_re where formalizes @ claim.riemann_zeta_zeros_on_line, has_type @ statement.RiemannZetaZerosOnLine
zil attach LFunction_ne_zero_of_half_lt_re where formalizes @ claim.dirichlet_l_nonvanishing_right_of_half, has_type @ statement.DirichletLNonvanishingRightOfHalf
zil attach LFunction_eq_zero_re where formalizes @ claim.dirichlet_l_zeros_on_line, has_type @ statement.DirichletLZerosOnLine
zil attach LFunction_eq_zero_re_of_isPrimitive where formalizes @ claim.primitive_dirichlet_l_zeros_on_line, has_type @ statement.PrimitiveDirichletLZerosOnLine

#zil_query "lean:riemannHypothesis"#formalizes@claim.riemann_hypothesis

example : RiemannHypothesis := by
  zil_apply claim.riemann_hypothesis

run_cmd do
  let env ← getEnv
  let allAttachments := Zil.Datalog.declarationAttachments env
  unless allAttachments.size == 10 do
    throwError "GRH-to-ZIL bridge expected ten declaration attachments"
  let linked := Zil.Datalog.declarationsForClaim env `claim.riemann_hypothesis
  unless linked.contains `riemannHypothesis do
    throwError "the Riemann Hypothesis theorem was not linked to its ZIL claim"
  let program := Zil.Datalog.currentProgram env
  unless program.facts.length == 10 do
    throwError "the GRH declaration attachments were not materialized as ZIL facts"
