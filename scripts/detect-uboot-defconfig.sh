#!/bin/bash
# Auto-detect the correct U-Boot defconfig for E20C/RK3528
# This script checks what defconfigs are available in the Radxa U-Boot repo

set -e

UBOOT_DIR="$1"
if [ -z "$UBOOT_DIR" ]; then
    echo "Usage: $0 <u-boot-source-dir>"
    exit 1
fi

cd "$UBOOT_DIR"

# Try known defconfig names in order
CANDIDATES=(
    "radxa-e20c-rk3528_defconfig"
    "radxa_e20c_defconfig"
    "e20c-rk3528_defconfig"
    "evb-rk3528_defconfig"
    "rk3528_defconfig"
)

for defconfig in "${CANDIDATES[@]}"; do
    if [ -f "configs/${defconfig}" ]; then
        echo "FOUND: ${defconfig}"
        exit 0
    fi
done

echo "ERROR: No suitable U-Boot defconfig found for E20C/RK3528!"
echo "Checked: ${CANDIDATES[*]}"
echo "Available RK3528 configs:"
ls configs/*rk3528* 2>/dev/null || echo "  (none found with 'rk3528' in name)"
ls configs/*e20c* 2>/dev/null || echo "  (none found with 'e20c' in name)"
exit 1
