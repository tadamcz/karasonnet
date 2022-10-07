#!/bin/zsh
jsonnetfmt ./jsonnet/**/*.{jsonnet,libsonnet} --in-place
jsonnet ./jsonnet/karabiner.jsonnet > karabiner.json