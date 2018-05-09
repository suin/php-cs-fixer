#!/bin/sh
set -e

isCommand() {
  for cmd in \
    "describe" \
    "fix" \
    "help" \
    "list" \
    "readme" \
    "self-update"
  do
    if [ -z "${cmd#"$1"}" ]; then
      return 0
    fi
  done

  return 1
}

if [ "${1:0:1}" = "-" ]; then
  set -- /sbin/tini -- php /vendor/bin/php-cs-fixer "$@"
elif [ "$1" = "/vendor/bin/php-cs-fixer" ]; then
  set -- /sbin/tini -- php "$@"
elif [ "$1" = "php-cs-fixer" ]; then
  set -- /sbin/tini -- php /vendor/bin/"$@"
elif isCommand "$1"; then
  set -- /sbin/tini -- php /vendor/bin/php-cs-fixer "$@"
fi

exec "$@"
