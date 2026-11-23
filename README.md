# Quantum Relational Causality: preprint and checks

Version 1.0.0. Preprint: `paper/qrc_preprint.pdf` (17 pages), source `paper/qrc_preprint.tex`.

## What QRC is

Quantum Relational Causality (QRC) is an independent research program investigating discrete
relational actions on matching groupoids. Its governing operational principle is that
**distance is the inferred measurement of causal impedance** between physical states, rather than
an independent background container. 

The program explores whether spatial dimensionality, gauge symmetries, and metric structures can be
recovered from combinatorial relations without positing continuous space as a primitive. The project's
proof obligations are organised into a sequence of explicit, falsifiable gates.

## What the preprint claims

- For a declared source law S_pre^NR on finite sets D of excitation types with transverse
  matchings to their binary spans, the unique ground state for activity 0 < h < 2 lambda is
  |D| = 3 with the complement matching, with gap min(3h, 2 lambda - h). Proved in full in
  the paper and checked by exhaustive enumeration.
- Under two further declared laws (least endpoint completion and a centred unit-rate
  walk): endpoint group Z[D] of rank three, word-ball count V_3(R) = (4R^3+6R^2+8R+3)/3,
  return probability e^{-t} I_0(t/3)^3, spectral dimension three, and one co-metric
  q# = (1/3) sum_d d (x) d.
- On a supplied Hermitian 2+3 internal carrier with one determinant record: stabilizer
  S(U(2) x U(3)) = (SU(2) x SU(3) x U(1))/Z_6, one anomaly-free 15-state chiral family, and
  a pair-dual anomaly polynomial (m+n-5) ch_3(E) that selects ranks 2+3 within its own
  hypotheses.

## What it does not claim

- That the source law follows from the foundational statement or from nonlocality.
- That nature obeys any QRC law. An implication theorem for a declared law is not
  evidence that nature obeys the law.
- That word length or diffusion time has been identified with measured distance or time.
- Lorentzian spacetime, a quantum continuum, gravity, gauge dynamics (photon, confinement,
  chiral measure, mirror removal) or a particle spectrum. These are open (Gates 2 to 6).
- An absolute length scale.

The paper also lists corrections to earlier claims of the program, including six that
failed independent audit (Section 7), and fits the remaining cosmology candidates to
public data (Section 8). One phenomenological causal-memory dark-energy model fits at the
level of LCDM; the data neither prefer nor exclude it, and its physical origin is open.

## Run the checks

Requirements: Python 3 with numpy and scipy. Each script reads no files and writes nothing.

```sh
cd checks
python3 -I -B check_gate1_selection.py   # Gate 1 rank selection, exhaustive, 47 tests, about 1 s
python3 -I -B check_gate_results.py      # V_3, heat kernel, d_s, q#, Z_6 quotient, I_6; 26 tests, about 1 s
python3 -I -B check_gate5_family.py      # family, anomalies, Z_6 descent, Higgs charge, beta coefficients; 18 tests
./run_checks.sh                          # runs all three and reports their exit status
```

Every script prints one line per test with the observed and the expected outcome. Some
tests deliberately use wrong inputs (h outside the window, ternary spans, dropped
transversality, wrong formulas, a buggy enumerator) and are expected to FAIL; the script
exits with status 0 only if every observed outcome equals its expectation. Saved output is
in `checks/expected_output/` (timings in those files will differ from run to run).

Test quality: line coverage is 99 percent for `check_gate1_selection.py` and 100 percent
for the other two (coverage.py 6.5). No automated mutation tool was run. Hand-made mutants
of the selection check were detected except three that are equivalent on the tested
inputs; they are listed in Appendix A of the paper.

The cosmology harness and its data sources are described in `checks/cosmology/README.md`.
The data are public but not redistributed here.

## Build the PDF

```sh
./build.sh
```

Requires `pdflatex` with standard packages (amsmath, amsthm, booktabs, tabularx,
microtype, lmodern, hyperref). No bibtex or latexmk is needed. Auxiliary files are kept in
a temporary directory, so only the PDF is written to `paper/`.

## Layout

```
paper/            preprint source and PDF
checks/           mathematical checks and their saved output
checks/cosmology/ real-data cosmology harness, data README, saved results
build.sh          PDF build
CITATION.cff      citation metadata
.zenodo.json      Zenodo deposit metadata
LICENSE           MIT
```

## License

MIT, see `LICENSE`.
