#!/bin/bash
command -v bc >/dev/null || { echo "bc가 필요합니다." >&2; exit 1; }
marks=()
summary() {
    total=0
    for mark in "${marks[@]}"; do total=$((total + mark)); done
    size=${#marks[@]}
    mean=$(printf 'scale=2; %d / %d\n' "$total" "$size" | bc)
    if (( total >= 90 * size )); then letter=A; else letter=B; fi
}
while :; do
    echo "[1] 추가 [2] 목록 [3] 평균 [4] 등급 [5] 종료"
    read -r -p "선택: " option || break
    case "$option" in
        1)
            read -r -p "점수: " mark || break
            if ! [[ $mark =~ ^[0-9]{1,3}$ ]] || (( 10#$mark > 100 )); then
                echo "입력 오류: 0~100의 정수를 입력하세요."
                continue
            fi
            marks+=("$((10#$mark))")
            printf '저장 완료 (%d과목)\n' "${#marks[@]}"
            ;;
        2|3|4)
            if (( ${#marks[@]} == 0 )); then
                echo "저장된 점수가 없습니다."
                continue
            fi
            case "$option" in
                2) printf '점수 목록: %s\n' "${marks[*]}" ;;
                3) summary; printf '평균: %s\n' "$mean" ;;
                4) summary; printf '평균 등급: %s (%s점)\n' "$letter" "$mean" ;;
            esac
            ;;
        5) echo "성적 관리를 마칩니다."; break ;;
        *) echo "입력 오류: 1~5 중에서 선택하세요." ;;
    esac
done
