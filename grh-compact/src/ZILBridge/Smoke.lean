import ZILBridge
open Zil.Datalog
def grhZilSmokeFact : Atom :=
  { object := .symbol "grh", relation := "formalizes",
    subject := .symbol "DirichletLFunctions" }
def grhZilSmokeProgram : Program := { facts := [grhZilSmokeFact] }
example : grhZilSmokeFact ∈ grhZilSmokeProgram.facts := by simp [grhZilSmokeProgram]
example : Holds grhZilSmokeProgram grhZilSmokeFact := by
  exact Derives.fact (by simp [grhZilSmokeProgram])
