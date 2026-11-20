#!/bin/bash
set -e
if (( $# > 1 )); then echo "사용법: $0 [새 폴더]" >&2; exit 1; fi
folder=${1:-files}
case "$folder" in ''|-*) echo "폴더 이름을 확인하세요." >&2; exit 1 ;; esac
archive="$folder.tar"
if [ -e "$folder" ] || [ -L "$folder" ] || [ -e "$archive" ] || [ -L "$archive" ]; then
    echo "기존 결과가 있습니다. 새 이름을 지정하세요." >&2
    exit 1
fi
mkdir -p "$folder/original" "$folder/restored"
for ((n=0; n<5; n++)); do
    printf 'sample number %d\n' "$n" > "$folder/original/file$n.txt"
done
tar -cf "$archive" -C "$folder/original" file0.txt file1.txt file2.txt file3.txt file4.txt
printf '묶음 파일: %s\n' "$archive"
tar -tf "$archive"
tar -xf "$archive" -C "$folder/restored"
echo "복원한 파일:"
ls -1 "$folder/restored"
diff -r "$folder/original" "$folder/restored"
echo "비교 결과: 5개 파일 모두 일치"
