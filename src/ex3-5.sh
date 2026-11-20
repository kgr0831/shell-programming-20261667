#!/bin/bash
list_entries() {
    echo "목록 조회 시작"
    echo "list_entries 함수 실행"
    ls "$@"
    code=$?
    echo "목록 조회 끝"
    return "$code"
}
if (( $# > 0 )); then
    list_entries "$@"
    exit $?
fi
platform=$(uname -s)
printf '운영체제: %s\n' "$platform"
while :; do
    echo "[1] 사용자 [2] CPU [3] 메모리 [4] 디스크 [5] 파일 [6] 종료"
    read -r -p "선택: " option || break
    case "$option" in
        1)
            printf '사용자: '; whoami
            printf 'UID: '; id -u
            printf '기본 그룹: '; id -gn
            ;;
        2)
            if [ "$platform" = Darwin ]; then
                LC_ALL=C top -l 1 -n 0 | awk '/CPU usage/ {print}'
            else
                LC_ALL=C top -b -n 1 | sed -n '1,5p'
            fi
            ;;
        3)
            if [ "$platform" = Darwin ]; then vm_stat | sed -n '1,6p'
            else free -h; fi
            ;;
        4) df -h . ;;
        5) list_entries -l ;;
        6) echo "조회를 마칩니다."; break ;;
        *) echo "입력 오류: 1~6 중에서 선택하세요." ;;
    esac
done
