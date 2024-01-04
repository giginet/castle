#/usr/bin/env bash
if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  FILES=`git ls-files`
else
  FILES=`/bin/ls -p | grep -v /`
fi
candidates=("Package.swift" ".xcodeproj" ".xcworkspace")
for file in ${FILES[@]}
do
  for candidate in ${candidates[@]}
  do
    if [[ $file =~ $candidate ]]; then
      exit 0
    fi
  done
done
exit 1

