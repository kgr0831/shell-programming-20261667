#!/bin/bash
if (( $# < 2 )); then
    echo "사용법: $0 <점수1> <점수2> ..." >&2
    exit 1
fi
command -v bc >/dev/null || { echo "bc가 필요합니다." >&2; exit 1; }
for mark in "$@"; do
    if ! [[ $mark =~ ^[0-9]{1,3}$ ]] || (( 10#$mark > 100 )); then
        echo "입력 오류: 점수는 0~100의 정수입니다." >&2
        exit 1
    fi
done
grade_of() {
    if (( $1 >= 90 )); then echo A; else echo B; fi
}
total=0
subject=0
printf '과목\t점수\t등급\n'
for mark in "$@"; do
    mark=$((10#$mark))
    subject=$((subject + 1))
    total=$((total + mark))
    printf '%d\t%d\t%s\n' "$subject" "$mark" "$(grade_of "$mark")"
done
mean=$(printf 'scale=2; %d / %d\n' "$total" "$subject" | bc)
printf '합계: %d / 과목 수: %d\n' "$total" "$subject"
printf '평균: %s / 평균 등급: %s\n' "$mean" "$(grade_of "$((total / subject))")"
