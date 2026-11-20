#!/bin/bash
if [ "$#" -gt 1 ]; then
    echo "사용법: $0 [설정 파일]" >&2
    exit 1
fi
config=${1:-./.bashrc}
setting='export MYENV="Bash Ready"'
touch "$config" || exit 1
if grep -Fxq "$setting" "$config"; then
    echo "등록 상태: 이미 저장됨"
else
    printf '%s\n' "$setting" >> "$config" || exit 1
    echo "등록 상태: 새로 저장됨"
fi
source "$config" || exit 1
printf '현재 셸: MYENV=%s\n' "$MYENV"
bash -c 'printf "자식 셸: MYENV=%s\n" "$MYENV"'
unset MYENV
printf '해제 후: MYENV=%s\n' "${MYENV-미설정}"
