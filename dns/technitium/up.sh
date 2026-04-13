#!/usr/bin/env bash
set -euo pipefail

# ─── up.sh ───────────────────────────────────────────────────────────────────
# Starts the Technitium DNS container and points the host resolver to it.
# Run configure-technitium.sh once before using this script.
# ─────────────────────────────────────────────────────────────────────────────

COMPOSE_FILE="$(dirname "$0")/docker-compose.yml"
WAIT_SECONDS=5
DOCKER="docker"

echo "[1/3] Starting Technitium DNS container..."
"${DOCKER}" compose -f "${COMPOSE_FILE}" up -d --remove-orphans

echo "[2/3] Waiting ${WAIT_SECONDS}s for container to initialize..."
sleep "${WAIT_SECONDS}"

# Verify the container is actually running before switching resolver
if ! "${DOCKER}" inspect -f '{{.State.Running}}' technitium-dns 2>/dev/null | grep -q "true"; then
    echo "ERROR: Container did not start correctly. Check logs:"
    echo "       ${DOCKER} logs technitium-dns"
    exit 1
fi

echo "[3/3] Pointing /etc/resolv.conf to localhost..."
echo "nameserver 127.0.0.1" | sudo tee /etc/resolv.conf > /dev/null

echo ""
echo "Technitium DNS is up."
echo "  Web UI  : http://$(hostname -I | awk '{print $1}'):5380"
echo "  Logs    : docker logs -f technitium-dns"
