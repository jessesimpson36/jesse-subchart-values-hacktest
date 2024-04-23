#!/bin/bash
HELM_DIR=/home/jesse/code/helm
WORK_DIR=$PWD

function run_template() {
	output="$(~/code/helm/bin/helm template -f values-override.yaml test .)"
	if [[ "$output" != "" ]]; then
		echo "Success"
	else
		echo "Failed"
	fi
}

echo "===== TEST  running helm template ======"

# Test helm template
./switch.sh 0 0
echo "Unnested without Underscore"
run_template
./switch.sh 0 1
echo "Unnested, with Underscore"
run_template
./switch.sh 1 0
echo "Nested, without Underscore"
run_template
./switch.sh 1 1
echo "Nested, with Underscore"
run_template


function run_test() {
	cd $HELM_DIR
	go test -count=1 -run "^TestValuesHackAffectsSubchart$" ./... > /dev/null 2> /dev/null
	if [[ "$?" == "0" ]]; then
		echo "Success"
	else
		echo "Failed"
	fi
	cd $WORK_DIR
}

echo "===== TEST  running helm integration test ======"

# Test unit test
./switch.sh 0 0
echo "Unnested without Underscore"
run_test
./switch.sh 0 1
echo "Unnested, with Underscore"
run_test
./switch.sh 1 0
echo "Nested, without Underscore"
run_test
./switch.sh 1 1
echo "Nested, with Underscore"
run_test
