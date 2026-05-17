#!/bin/bash
# Generate an lcov report for Pin.cpp (host unit tests). Requires: cmake, ninja, lcov, gcov
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD="${ROOT}/build-tests"

rm -rf "${BUILD}"
cmake -S "${ROOT}/tests" -B "${BUILD}" -G Ninja -DENABLE_COVERAGE=ON
cmake --build "${BUILD}"
ctest --test-dir "${BUILD}" --output-on-failure

INFO="${BUILD}/coverage.info"
lcov --capture --directory "${BUILD}" --output-file "${INFO}" \
    --rc branch_coverage=1 --ignore-errors mismatch,negative
lcov --remove "${INFO}" \
    '*/tests/*' \
    '*/_deps/*' \
    '*/build-tests/*' \
    '/usr/*' \
    --output-file "${INFO}" --ignore-errors unused,negative

echo ""
echo "Coverage report: ${INFO}"
lcov --summary "${INFO}"
echo ""
echo "HTML report: run  genhtml ${INFO} -o ${BUILD}/coverage-html  &&  xdg-open ${BUILD}/coverage-html/index.html"
