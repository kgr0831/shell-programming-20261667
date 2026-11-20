#!/bin/bash
if (( $# != 1 )) || [ -z "$1" ]; then
    echo "사용법: $0 <검색어>" >&2
    exit 1
fi
if [ ! -f DB.txt ]; then
    echo "DB.txt가 없습니다. 먼저 데이터를 추가하세요." >&2
    exit 1
fi
printf '검색어: %s\n' "$1"
grep -iF -- "$1" DB.txt
result=$?
case "$result" in
    0) ;;
    1) echo "일치하는 기록이 없습니다." ;;
    *) echo "DB.txt 읽기 오류" >&2; exit "$result" ;;
esac
