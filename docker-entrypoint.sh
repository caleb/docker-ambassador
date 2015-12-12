#!/usr/bin/env bash
set -e

declare -a args=()
declare -a containers=()

if [ -n "${LINKS}" ]; then
  for link in ${LINKS}; do
    containers+=("${link}")
  done
else
  echo "You must specify the LINKS environment variable as a space delimited list of containers" >&2
  exit 1
fi

for a in "${@}"; do
  args+=("${a}")
done

for c in "${containers[@]}"; do
  args+=("-name")
  args+=("${c}")
done

if [ "${1}" = "ambassador" ]; then
  args=("${args[@]:1}")

  echo "Running grand-ambassador \"/usr/bin/grand-ambassador ${args[@]}\""
  exec /usr/bin/grand-ambassador "${args[@]}"
else
  exec "${@}"
fi
