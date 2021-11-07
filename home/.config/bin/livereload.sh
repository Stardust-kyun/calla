#!/usr/bin/env bash

xrdb_query() {
    value=$(xrdb -query | grep -i "^*\.$1:" | cut -f 2)
    if [ -n "${value}" ]; then
      echo "${value}"
      return 0
    fi
  return 1
}

sequences=""
for i in $(seq 0 15); do
  sequences+="\033]4;${i};$(xrdb_query "color${i}")\007"
done

# foreground, background, and cursor.
sequences+="\\033]10;$(xrdb_query foreground)\\007"
sequences+="\\033]11;$(xrdb_query background)\\007"
sequences+="\\033]12;$(xrdb_query cursorColor)\\007"
sequences+="\\033]708;$(xrdb_query background)\\007"

for term in /dev/pts/[0-9]*; do
  printf "%b" "${sequences}" > "${term}" &
  # echo "Applied to $term"
done
echo "All terminal colors reloaded"
