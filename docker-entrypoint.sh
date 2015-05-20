#!/usr/bin/env bash
set -e

declare -a args=()
declare -a containers=()

env | grep '[^=]*_NAME=/' > /tmp/links

while read -u 10 e; do
  if [[ "${e}" =~ ^[^=]*_NAME=/([^/]*)/(.*)$  ]]; then
    link_alias="${BASH_REMATCH[2]}"
    this_container_name="${BASH_REMATCH[1]}"

    tail -n +8 /etc/hosts > /tmp/hosts

    # loop through the hosts file
    while read -u 11 h; do
      a="$(echo "${h}" | awk '{print $2;}')"
      if [ "${a,,}" = "${link_alias,,}" ]; then
        id="$(echo "${h}" | awk '{print $3;}')"
        containers+=("${id}")
      fi
    done 11< /tmp/hosts
  fi
done 10< /tmp/links

rm -f /tmp/links
rm -f /tmp/hosts

for c in "${containers[@]}"; do
  args+=("-name")
  args+=("${c}")
done

for a in "${@}"; do
  args+=("${a}")
done

echo "Running grand-ambassador \"/usr/bin/grand-ambassador ${args[@]}\""
exec /usr/bin/grand-ambassador "${args[@]}"
