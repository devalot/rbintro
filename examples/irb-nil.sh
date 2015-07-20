#!/bin/sh

# Like irb.sh, but remove nils.
`dirname $0`/irb.sh | sed 's/;[ ]*nil//g' | grep -v -- '=> nil'
