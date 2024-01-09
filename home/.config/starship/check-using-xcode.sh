#/usr/bin/env bash
FILES=`/bin/ls -1 -a`
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

