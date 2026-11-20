#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "사용법: $0 <정수> <정수>" >&2
    exit 1
fi
for number in "$@"; do
    if ! [[ $number =~ ^-?[0-9]{1,9}$ ]]; then
        echo "입력 오류: 부호를 제외한 9자리 이하 정수만 가능합니다." >&2
        exit 1
    fi
done
decimal() {
    case "$1" in
        -*) echo "$((-10#${1#-}))" ;;
        *) echo "$((10#$1))" ;;
    esac
}
left=$(decimal "$1")
right=$(decimal "$2")
printf '입력: %d, %d\n' "$left" "$right"
printf '더하기: %d\n' "$((left + right))"
printf '빼기:   %d\n' "$((left - right))"
printf '곱하기: %d\n' "$((left * right))"
if (( right == 0 )); then
    echo "나누기: 계산 불가 (분모 0)"
else
    printf '나누기: %d (정수 몫)\n' "$((left / right))"
fi
