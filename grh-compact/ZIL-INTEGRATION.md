# ZIL integration plan

This GRH project and [ZIL](https://github.com/jagg-ix/zil-lean) use different
Lean toolchains at their current upstream revisions:

- GRH compact: Lean 4.35.0; Mathlib commit
  `56a005855ea17e0b0958f73ec801ae140b0a1679`.
- ZIL: Lean 4.31.0; upstream package `«zil-lean»`.

A direct Lake `require` would therefore combine projects with incompatible
toolchain pins. Do not change the GRH toolchain or Mathlib pin to work around
this mismatch: the GRH files have been checked against their current setup.

## ZIL library surface

The useful Lean-level integration boundary is the ZIL Datalog layer:
`Zil.Datalog.Basic`, `Unify`, `Eval`, `Semantics`, `Model`,
`LeastModel`, `Stratified`, `Checked`, `Certify`, `Matching`,
`Perfect`, and `Tactic.Solve`. It provides ground atoms, rule programs,
unification, executable evaluation, derivation/model semantics, stratification,
checked evaluation, certificate checking, and tactics.

The upstream root `Zil.lean` additionally imports a broader surface and the
native project is much larger. GRH should initially consume the proof-oriented
Datalog modules only, not the CLI, worker, persistence, networking, or runtime.

## Pinned upstream revision

The current ZIL source revision inspected for this integration is:

`7de6db8b6ce5f5c83667a3a93e05bc80649e4a06`

Source: https://github.com/jagg-ix/zil-lean/tree/7de6db8b6ce5f5c83667a3a93e05bc80649e4a06

## Recommended integration sequence

1. Add a Lean 4.35-compatible revision/toolchain to ZIL upstream (or publish a
   compatibility branch) and verify its Datalog targets against the GRH
   Mathlib revision.
2. Add that compatible ZIL revision as a Lake dependency in `grh-compact`.
3. Import only the required Datalog modules through a local `GRH.ZIL` facade.
4. Add smoke tests that encode GRH proof metadata/relations as ZIL facts and
   rules, while keeping all theorem proofs in the existing GRH namespaces.
5. Compare ZIL-derived dependency/claim graphs with the source declarations;
   do not treat graph consistency as proof of the Riemann or Generalized
   Riemann Hypothesis.

## Current status

This commit documents the incompatibility and preserves both existing pins.
It does not yet compile ZIL inside the GRH Lake project. A source-vendored
snapshot would need compatibility validation under Lean 4.35 before it can be
claimed as an integrated dependency.
