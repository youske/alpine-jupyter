#!/bin/sh -e
jupyter notebook &
#cat <<EOF >>~/.bashrc
#trap " exit 0" TERM
#EOF
exec /bin/sh
