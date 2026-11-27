# ZIL integration

The compact GRH Lake project now includes the proof-oriented Datalog modules
from [jagg-ix/zil-lean](https://github.com/jagg-ix/zil-lean).

## Source and compatibility

The source is pinned to ZIL commit
7de6db8b6ce5f5c83667a3a93e05bc80649e4a06. The files under src/Zil/Datalog are copied verbatim from
that revision; their upstream module names and imports are preserved.

The GRH compact project pins Lean 4.35.0 and Mathlib commit
56a005855ea17e0b0958f73ec801ae140b0a1679. The ZIL repository's
lean-toolchain at the pinned source revision says Lean 4.31.0. To keep the
GRH build pinned, this integration vendors only the selected source modules
instead of declaring an upstream Lake dependency. No Lean or Mathlib pin in
the GRH project has been changed.

The selected modules cover the ZIL Datalog ground model, unification, evaluation,
derivation semantics, model theory, least-model reasoning, stratification,
checked evaluation, proof certificates, matching correctness, perfect-model
results, and the zil_solve / zil_refute tactics. The local src/Zil.lean
file is a curated import root for this subset; it is not a copy of the full
upstream Zil.lean root.

This does not bring in ZIL's native knowledge/application stack, external
.zc parser, CLI, worker, persistence, networking, or runtime services.
Those components remain outside the integration boundary.

## Build and smoke test

From grh-compact/:

```sh
lake build Zil ZilSmoke
lake env lean src/Zil/Datalog/Smoke.lean
```

The smoke test checks a ground fact, the checked evaluator's positive answer,
and the zil_solve tactic against a fact program.

## Updating

To refresh the snapshot, choose a ZIL revision explicitly, review its Datalog
module dependency graph and license, copy the selected modules, then rerun
lake build Zil ZilSmoke under the pinned GRH toolchain. Do not update
lean-toolchain merely to consume ZIL: a coordinated toolchain/Mathlib
upgrade must be evaluated against the complete GRH proof tree.

## Trust boundary

The Datalog proof results apply to the ZIL programs and semantics represented
by these modules. They do not by themselves prove the Riemann Hypothesis,
the Generalized Riemann Hypothesis, or the correctness of any mapping from
GRH source declarations to ZIL facts. Such a mapping needs its own
soundness/completeness statement and machine-checked proof.
