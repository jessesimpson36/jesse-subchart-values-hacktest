#!/bin/bash
# Usage: switch.sh <nested> <underscore>
#
# nested:     expected 0 (unnested)      or 1 (nested)
# underscore: expected 0 (no underscore) or 1 (underscore)

SHOULD_NEST="$1"
SHOULD_UNDERSCORE="$2"
FILENAME=z_compatibility_helpers.tpl

if [ $SHOULD_NEST -eq 1 ]; then
	if [ -d templates/1 ]; then
		echo
	else
		mkdir -p templates/1/2/3/4/5/6/7/8
		mv templates/*$FILENAME templates/1/2/3/4/5/6/7/8/
	fi
fi


if [ $SHOULD_NEST -eq 0 ]; then
	if [ -d templates/1 ]; then
		mv templates/1/2/3/4/5/6/7/8/* templates/
		rm -r templates/1
	else
		echo
	fi
fi

FOUND=$(find templates -name "*$FILENAME")
BASENAME=$(basename $FOUND)
DIRNAME=$(dirname $FOUND)
if [ $SHOULD_UNDERSCORE -eq 1 ]; then
	if [[ "$BASENAME" == "_$FILENAME" ]]; then
		echo
	else
		mv $FOUND $DIRNAME/_$FILENAME
	fi
fi

if [ $SHOULD_UNDERSCORE -eq 0 ]; then
	if [[ "$BASENAME" == "_$FILENAME" ]]; then
		mv $FOUND $DIRNAME/$FILENAME
	else
		echo
	fi
fi


