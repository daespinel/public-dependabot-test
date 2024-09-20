#!/bin/bash

set -euo pipefail

exec gosu python:python "$@"
