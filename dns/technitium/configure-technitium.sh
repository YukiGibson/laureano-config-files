#!/usr/bin/env bash
set -euo pipefail

# ─── configure-technitium.sh ─────────────────────────────────────────────────
# Prepares the system to run Technitium DNS in Docker.
# - Disables systemd-resolved to free port 53
# - Sets a temporary upstream resolver in /etc/resolv.conf
# Run this once before the first `up.sh` call.
# ─────────────────────────────────────────────────────────────────────────────

TEMP_RESOLVER="1.1.1.1"

echo "[1/3] Disabling systemd-resolved..."
if systemctl is-active --quiet systemd-resolved; then
    systemctl disable systemd-resolved --now
    echo "      systemd-resolved stopped and disabled."
else
    echo "      systemd-resolved is not running, skipping."
fi

echo "[2/3] Removing managed /etc/resolv.conf..."
if [ -L /etc/resolv.conf ] || [ -f /etc/resolv.conf ]; then
    rm -f /etc/resolv.conf
fi

echo "[3/3] Writing temporary resolver (${TEMP_RESOLVER})..."
echo "nameserver ${TEMP_RESOLVER}" | tee /etc/resolv.conf > /dev/null

echo ""
echo "Done. System is ready — run ./up.sh to start Technitium."
echo "After the container is up, /etc/resolv.conf will be updated to 127.0.0.1."
