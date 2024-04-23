#!/bin/bash

if [ -d templates/1 ]; then
	mv templates/1/2/3/4/5/6/7/8/* templates
	rm -r templates/1
else
	mkdir -p templates/1/2/3/4/5/6/7/8
	mv templates/z* templates/1/2/3/4/5/6/7/8/
fi
