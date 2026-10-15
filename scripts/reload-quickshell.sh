#!/usr/bin/env bash
set -euo pipefail
pkill -x quickshell 2>/dev/null || true
sleep 0.5
nohup quickshell -c garbanzo >/tmp/garbanzo-qs.log 2>&1 &
echo "Garbanzo Quickshell restarted."