#!/bin/bash
if (( $# != 2 )) || [ -z "$1" ] || [ -z "$2" ]; then
    echo "사용법: $0 <이름> <전화번호 또는 생일>" >&2
    exit 1
fi
case "$1$2" in
    *$'\n'*|*$'\r'*|*$'\t'*) echo "줄바꿈과 탭은 입력할 수 없습니다." >&2; exit 1 ;;
esac
printf '%s\t%s\n' "$1" "$2" >> DB.txt || exit 1
printf '추가: %s | %s\n' "$1" "$2"
