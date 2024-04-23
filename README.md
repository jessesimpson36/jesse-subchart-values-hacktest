
# Subchart values hacktest

## What is this?

This repo is an investigation into how helm renders templates with subcharts in a scenario where the template writes into a subcharts Values.


## Explanation of files:

1. `switch.sh` -  These files will switch between two modes where `z_compatibility_helpers.tpl` is deeply nested into a folder structure and where it is not.
2. Generic helm chart files (`Chart.yaml`, `values.yaml`, ...) - The helm chart is a simple subchart structure where only one file in the nested subchart gets rendered.
3. `test.sh` - This file will test a grid between whether z_compatibility_helpers.tpl starts with underscore, nested vs unnested, and running helm template vs my integration test in upstream helm.
4. `test_output` - output of test.sh


## What did I find?

As it turns out, there is a sort order to how the templates get rendered. This ordering is the most deeply nested files first and then traverses outward from there.

## Why is this relevant?

If a template `z_compatibility_helpers.tpl` adds a key into `.Values`, and another template `ingress.yaml` depends on that key, then we need `z_compatibility_helpers.tpl` to be rendered first so that the key gets loaded.

However, subcharts by nature are nested filesystems, which means they get rendered first. So the finding is that if we want the `z_compatibility_helpers.tpl` file to be rendered first, it must be in a deeply nested folder.

## How can I further investigate helm to play around with this?

I have an integration test on a fork of helm located here:
https://github.com/jessesimpson36/helm/commit/69866638a5be6b4efc4ab070dc13611421cd74bf


