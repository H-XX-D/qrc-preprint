#!/usr/bin/env bash
# Compile paper/qrc_preprint.tex to paper/qrc_preprint.pdf with pdflatex.
# Runs up to three passes until cross-references are stable. Auxiliary files go to a
# temporary directory that is removed on exit, so only the PDF is left in paper/.
# Requires pdflatex with standard packages (amsmath, amsthm, booktabs, tabularx,
# microtype, lmodern, hyperref). No bibtex or latexmk is needed.
set -euo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
src="$here/paper/qrc_preprint.tex"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

cd "$here/paper"
for pass in 1 2 3; do
  if ! pdflatex -interaction=nonstopmode -halt-on-error -output-directory="$tmp" "$src" > "$tmp/pass$pass.out" 2>&1; then
    echo "pdflatex failed on pass $pass; last lines of the log:" >&2
    tail -n 40 "$tmp/pass$pass.out" >&2
    exit 1
  fi
  if [ "$pass" -ge 2 ] && ! grep -q "Rerun to get" "$tmp/qrc_preprint.log"; then
    break
  fi
done

cp "$tmp/qrc_preprint.pdf" "$here/paper/qrc_preprint.pdf"
pages="$(tr -d '\n' < "$tmp/qrc_preprint.log" | grep -o -E '\(([0-9]+) pages?' | grep -o -E '[0-9]+' | tail -n 1 || true)"
warnings="$(grep -c -E 'LaTeX Warning|Overfull|Undefined' "$tmp/qrc_preprint.log" || true)"
underfull="$(grep -c 'Underfull' "$tmp/qrc_preprint.log" || true)"
echo "Built paper/qrc_preprint.pdf: ${pages:-?} pages, $pass pdflatex passes, $warnings warnings or overfull boxes, $underfull underfull boxes."
