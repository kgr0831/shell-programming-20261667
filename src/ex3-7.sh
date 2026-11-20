#!/bin/bash
set -e
if (( $# > 1 )); then echo "사용법: $0 [새 폴더]" >&2; exit 1; fi
folder=${1:-files}
case "$folder" in ''|-*) echo "폴더 이름을 확인하세요." >&2; exit 1 ;; esac
if [ -e "$folder" ] || [ -L "$folder" ]; then
    echo "기존 폴더가 있습니다. 새 이름을 지정하세요." >&2
    exit 1
fi
mkdir -p "$folder"
for ((n=0; n<5; n++)); do
    printf 'linked sample %d\n' "$n" > "$folder/file$n.txt"
    mkdir "$folder/file$n"
    ln -s "../file$n.txt" "$folder/file$n/file$n.txt"
done
echo "생성 목록:"
ls -1 "$folder"
echo "링크 경로:"
for ((n=0; n<5; n++)); do
    printf 'file%d/file%d.txt -> %s\n' "$n" "$n" "$(readlink "$folder/file$n/file$n.txt")"
    cmp "$folder/file$n.txt" "$folder/file$n/file$n.txt"
done
printf '첫 번째 링크의 내용: '
cat "$folder/file0/file0.txt"
echo "비교 결과: 링크 5개 모두 정상"
