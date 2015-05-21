#!/usr/bin/env bash
set -e

declare -a args=()
declare -a containers=()

if [ -n "${LINKS}" ]; then
  for link in ${LINKS}; do
    containers+=("${link}")
  done
else
  echo "You must specify the LINKS environement variable as a space delimited list of containers" >&2
  exit 1
fi

for c in "${containers[@]}"; do
  args+=("-name")
  args+=("${c}")
done

for a in "${@}"; do
  args+=("${a}")
done

if [ "${1}" = "ambassador" ]; then
  echo "Running grand-ambassador \"/usr/bin/grand-ambassador ${args[@]:1}\""
  exec /usr/bin/grand-ambassador "${args[@]:1}"
else
  exec "${@}"
fi
