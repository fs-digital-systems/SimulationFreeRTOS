#!/usr/bin/env bash
set -euo pipefail

project_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
demo="$project_dir/app-build/cmsis_freertos_demo"

"$project_dir/build.sh"
exec "$demo"
