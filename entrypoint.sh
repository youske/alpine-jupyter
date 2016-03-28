#!/bin/sh -e
[ "$1" = 'jupyter notebook' ] && {chown -R jupyter . ; exec gosu jupyter "$@" ; } || :
exec "$@"
