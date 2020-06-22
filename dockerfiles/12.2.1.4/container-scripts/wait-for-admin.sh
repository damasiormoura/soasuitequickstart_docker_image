#!/bin/sh
# wait-for-admin.sh

set -e

host="$1"
shift
cmd="$@"

until curl $host; do
  >&2 echo "Admin is unavailable - sleeping"
  sleep 1
done

>&2 echo "Admin is up - executing command"
exec $cmd