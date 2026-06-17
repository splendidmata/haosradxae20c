#!/bin/bash
# Post-build hook for HAOS E20C

function haos_pre_image() {
    local BOOT_DATA="$(path_boot_dir)"

    # Copy boot script
    cp "${BINARIES_DIR}/boot.scr" "${BOOT_DATA}/boot.scr"

    # Copy device trees
    cp "${BINARIES_DIR}/rk3528-radxa-e20c.dtb" "${BOOT_DATA}/"

    # Copy board config files
    cp "${BOARD_DIR}/boot-env.txt" "${BOOT_DATA}/haos-config.txt"
    cp "${BOARD_DIR}/cmdline.txt" "${BOOT_DATA}/cmdline.txt"

    # Copy E20C-specific loader if needed
    if [ -f "${BINARIES_DIR}/rk3528_spl_loader_v1.07.104.bin" ]; then
        cp "${BINARIES_DIR}/rk3528_spl_loader_v1.07.104.bin" "${BINARIES_DIR}/"
    fi
}

function haos_post_image() {
    convert_disk_image_xz
}
