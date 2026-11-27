# ZIL integration

The compact GRH Lake project includes the proof-oriented, Lean-embedded
Datalog DSL from [jagg-ix/zil-lean](https://github.com/jagg-ix/zil-lean).

## Source and compatibility

The source is pinned to ZIL commit `7de6db8b6ce5f5c83667a3a93e05bc80649e4a06`.
The selected files under `src/Zil/Datalog` preserve their upstream module
names, imports, declarations and proofs.

The GRH compact project pins Lean 4.35.0 and Mathlib commit
`56a005855ea17e0b0958f73ec801ae140b0a1679`. The pinned ZIL repository
declares Lean 4.31.0. To preserve the GRH build environment, this integration
vendors the Datalog source modules rather than requiring the complete upstream
Lake package. Neither GRH pin is changed.

## DSL and proof surface

The curated `import Zil` root exposes:

- Ground atoms, typed values, relation patterns, rules, and Datalog programs.
- The Lean-embedded commands `zil_fact`, `zil_rule`, `zil_macro`, `zil_use`,
  `zil_snapshot`, and `#zil_query`.
- `zil attach` for linking Lean declarations to persistent ZIL relations.
- Declaration metadata attributes `zil_claim`, `zil_concept`, `zil_requires`,
  `zil_level`, and `zil_export`, with the `zil_apply` tactic.
- Formalization contracts, theorem-intent declarations, and
  `#zil_formalization_lint`-family commands.
- Relation-level evaluation/environment, revision metadata, indexing and
  interoperability, alongside least-model, stratified, checked-evaluation,
  certificate, and perfect-model proof modules.

The Datalog sources are imported from upstream, not rewritten as a parallel
local semantics. The `Zil.Native` application engine, external `.zc` parser,
CLI, worker, persistence/network services, and `Zil.Horn` subsystem remain
outside this integration.

## GRH declaration bridge

`src/Zil/Test/GRHBridge.lean` imports the five established GRH declarations
from `Main.lean`, assigns stable ZIL claim/concept identifiers, and attaches
the theorem/type relations with `zil attach`. It checks that the environment
retains ten attachment facts and that `zil_apply` resolves the Riemann
Hypothesis claim to the original Lean theorem. These are traceability and
lookup checks only; they do not prove the encoding sound or complete and do
not add a proof of RH or GRH.

## Build and upstream regression tests

From `grh-compact/`:

```sh
lake build Zil ZilSmoke
```

`ZilSmoke` aggregates upstream tests copied verbatim from the pinned revision:

- `DatalogChecked`: long derivations, insufficient-fuel errors, checked queries,
  stratified negation, non-stratifiable programs, and the `zil_solve` /
  `zil_refute` tactics.
- `DatalogMacro`: expansion of the `zil_macro` and `zil_use` DSL commands.
- `DatalogCertify`: positive and negative certificate cases and proof checks.
- `DatalogPerfect`: ground matching and stable-model semantics.
- `GRHBridge`: the five theorem declarations, their ZIL metadata/relations,
  and claim-based application with `zil_apply`.

The workflow `.github/workflows/zil-datalog.yml` builds these targets using
the GRH toolchain. A passing build has not yet been observed; GitHub's
workflow jobs have terminated before runner steps executed, so those runs
are not Lean compilation results.

## Updating and trust boundary

Refresh this snapshot only after reviewing the upstream Datalog dependency
graph and license, then rerun `lake build Zil ZilSmoke` under the pinned GRH
toolchain. Do not change `lean-toolchain` merely to consume ZIL; a coordinated
toolchain/Mathlib upgrade must be evaluated against the full GRH proof tree.

ZIL's proofs establish properties of the Datalog programs represented by
these modules. They do not prove RH or GRH, nor do they prove that the GRH
formalization has been encoded faithfully into ZIL. That mapping requires
its own soundness/completeness statement and machine-checked proof.
