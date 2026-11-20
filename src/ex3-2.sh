#!/bin/bash
command -v bc >/dev/null || { echo "bc가 필요합니다." >&2; exit 1; }
if (( $# > 0 )); then
    values=("$@")
else
    read -r -p "x 입력 (공백으로 구분): " -a values
fi
if (( ${#values[@]} < 2 )); then
    echo "입력 오류: x를 2개 이상 입력하세요." >&2
    exit 1
fi
for x in "${values[@]}"; do
    if ! [[ $x =~ ^-?([0-9]+([.][0-9]*)?|[.][0-9]+)$ ]]; then
        echo "입력 오류: $x" >&2
        exit 1
    fi
done
echo "y = 0.5 * x^2"
printf '%-10s %s\n' 'x' 'y'
for x in "${values[@]}"; do
    y=$(printf 'scale=2; ((%s) * (%s) / 2)\n' "$x" "$x" | bc)
    case "$y" in .*) y="0$y" ;; esac
    printf '%-10s %s\n' "$x" "$y"
done
