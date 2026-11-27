import Zil

open Zil.Datalog

/-- A single fact used to verify the upstream Datalog API in the GRH toolchain. -/
def grhZilSmokeFact : Atom :=
  { object := .symbol "theorem.riemannHypothesis"
    relation := "formalizes"
    subject := .symbol "RiemannHypothesis" }

def grhZilSmokeProgram : Program :=
  { facts := [grhZilSmokeFact] }

example : grhZilSmokeFact ∈ grhZilSmokeProgram.facts := by
  simp [grhZilSmokeProgram]

example : holdsChecked grhZilSmokeProgram grhZilSmokeFact = .ok true := by
  native_decide

example : Holds grhZilSmokeProgram grhZilSmokeFact := by
  zil_solve
