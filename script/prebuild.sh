#!/bin/bash
# Usage: bash script/prebuild.sh [d2m/d2a/a2b]
# d2m: generate json model from dart file
# d2a: generate arb file from l10n.dart file
# a2d: generate l10n message releate file from arb file

d2m="flutter packages pub run build_runner build --delete-conflicting-outputs"
d2a="flutter pub run intl_translation:extract_to_arb --output-dir=l10n_arb lib/l10n/l10n.dart"
a2d="flutter pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/l10n/l10n.dart l10n_arb/intl_*.arb"

case ${1} in
    "")
        echo "Run dart to model"
        eval "${d2m}"
        echo "Run dart to arb"
        eval "${d2a}"
        echo "Run arb to dart"
        eval "${a2d}"
        ;;
    "d2m")
        echo "Run dart to model"
        eval "${d2m}"
        ;;
    "d2a")
        echo "Run dart to arb"
        eval "${d2a}"
        ;;
    "a2d")
        echo "Run arb to dart"
        eval "${a2d}"
        ;;
    *)
        echo "Illegal arguments, not argument: dart to arb and arb to dart, d2a: dart to arb, a2d arb to dart"
        echo "Provide arguments: ${arg}"
        echo "Run falied, nothing to do."
        exit 1
        ;;
esac
